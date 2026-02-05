import express from 'express'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const app = express()
const port = Number(process.env.PORT || 80)
const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const distPath = path.join(__dirname, 'dist')
const escapeHtml = (value) =>
  String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')

app.use(express.json({ limit: '256kb' }))

app.post('/telegram', async (req, res) => {
  const token = process.env.TELEGRAM_TOKEN
  const chatId = process.env.TELEGRAM_CHAT_ID || process.env.CHAT_ID

  if (!token || !chatId) {
    res.status(500).json({ error: 'Telegram ist nicht konfiguriert.' })
    return
  }

  const category = String(req.body?.category || 'sonstiges')
  const subject = String(req.body?.subject || '').trim()
  const description = String(req.body?.description || '').trim()
  const source = String(req.body?.source || '').trim()
  const page = String(req.body?.page || '').trim()

  if (!subject || !description) {
    res.status(400).json({ error: 'Betreff und Beschreibung sind erforderlich.' })
    return
  }

  const lines = [
    `Kategorie: ${escapeHtml(category)}`,
    `Betreff: ${escapeHtml(subject)}`,
    source ? `Source: ${escapeHtml(source)}` : null,
    page ? `Seite: ${escapeHtml(page)}` : null,
    '',
    'Beschreibung:',
    `<pre>${escapeHtml(description)}</pre>`
  ].filter(Boolean)

  try {
    const telegramResponse = await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        chat_id: chatId,
        text: lines.join('\n'),
        parse_mode: 'HTML',
        disable_web_page_preview: true
      })
    })

    if (!telegramResponse.ok) {
      const details = await telegramResponse.text()
      console.error('Telegram API error:', details)
      res.status(502).json({ error: 'Telegram konnte nicht erreicht werden.' })
      return
    }

    res.json({ ok: true })
  } catch (error) {
    console.error('Telegram request failed:', error)
    res.status(502).json({ error: 'Senden an Telegram fehlgeschlagen.' })
  }
})

app.use(express.static(distPath, { index: false }))
app.get('*', (_req, res) => {
  res.sendFile(path.join(distPath, 'index.html'))
})

app.listen(port, () => {
  console.log(`Distributor listening on :${port}`)
})
