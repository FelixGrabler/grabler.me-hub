<template>
  <div id="app">
    <header class="header" v-if="isHome">
      <div class="container header-inner">
        <h1>Grabler.me</h1>
        <p>Willkommen in meinem Projekt-Hub - entdecke meine verschiedenen Websites und Tools.</p>
      </div>
    </header>

    <main class="container">
      <div v-if="isHome" class="projects-grid">
        <a
          v-for="project in projects"
          :key="project.id"
          :href="project.url"
          class="project-tile"
          target="_blank"
          rel="noopener noreferrer"
        >
          <div class="project-image">
            <img :src="project.image" :alt="project.title" />
          </div>
          <div class="project-content">
            <h3 class="project-title">{{ project.title }}</h3>
            <p class="project-description">{{ project.description }}</p>
          </div>
        </a>
      </div>

      <section v-else-if="isImpressum" class="content-page">
        <h4>Impressum</h4>
        <p><b>Informationen und Offenlegung gemäß &sect;5 (1) ECG, &sect; 25 MedienG, &sect; 63 GewO und &sect; 14 UGB</b></p>
        <p><b>Webseitenbetreiber:</b> Felix Grabler</p>
        <p><b>Anschrift:</b> -, 8020 Graz</p>
        <p><b>UID-Nr:</b> <br /> <b>Gewerbeaufsichtbehörde:</b> <br /> <b>Mitgliedschaften:</b></p>
        <p><b>Kontaktdaten:</b> <br /> Telefon: <br /> Email: info@grabler.me <br /> Fax:</p>
        <p><b>Anwendbare Rechtsvorschrift:</b> www.ris.bka.gv.at <br /> <b>Berufsbezeichnung:</b></p>
        <p><b>Online Streitbeilegung:</b> Verbraucher, welche in Österreich oder in einem sonstigen Vertragsstaat der ODR-VO niedergelassen sind, haben die Möglichkeit Probleme bezüglich dem entgeltlichen Kauf von Waren oder Dienstleistungen im Rahmen einer Online-Streitbeilegung (nach OS, AStG) zu lösen. Die Europäische Kommission stellt eine Plattform hierfür bereit: https://ec.europa.eu/consumers/odr</p>
        <p><b>Urheberrecht:</b> Die Inhalte dieser Webseite unterliegen, soweit dies rechtlich möglich ist, diversen Schutzrechten (z.B dem Urheberrecht). Jegliche Verwendung/Verbreitung von bereitgestelltem Material, welche urheberrechtlich untersagt ist, bedarf schriftlicher Zustimmung des Webseitenbetreibers.</p>
        <p><b>Haftungsausschluss:</b> Trotz sorgfältiger inhaltlicher Kontrolle übernimmt der Webseitenbetreiber dieser Webseite keine Haftung für die Inhalte externer Links. Für den Inhalt der verlinkten Seiten sind ausschließlich deren Betreiber verantwortlich. Sollten Sie dennoch auf ausgehende Links aufmerksam werden, welche auf eine Webseite mit rechtswidriger Tätigkeit/Information verweisen, ersuchen wir um dementsprechenden Hinweis, um diese nach § 17 Abs. 2 ECG umgehend zu entfernen.<br />Die Urheberrechte Dritter werden vom Betreiber dieser Webseite mit größter Sorgfalt beachtet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden derartiger Rechtsverletzungen werden wir den betroffenen Inhalt umgehend entfernen.</p>
        <p>
          <span>Rechtstext von </span>Quelle:
          <a href="https://fairesrecht.at/kostenlos-impressum-erstellen-generator.php" target="_blank" rel="noopener noreferrer">Impressum Generator</a>
          in Kooperation mit
          <b><a href="https://rechtsanwaltwien.com/arzthaftung" target="_blank" rel="noopener noreferrer">Medizinrecht</a></b>
        </p>
      </section>

      <section v-else-if="isDsgvo" class="content-page">
        <h4>DSGVO</h4>
        <h3>Erklärung zur Informationspflicht</h3>
        <br />
        <p align="center"><strong>Datenschutzerklärung</strong></p>
        <p>In folgender Datenschutzerklärung informieren wir Sie über die wichtigsten Aspekte der Datenverarbeitung im Rahmen unserer Webseite. Wir erheben und verarbeiten personenbezogene Daten nur auf Grundlage der gesetzlichen Bestimmungen (Datenschutzgrundverordnung, Telekommunikationsgesetz 2003).</p>
        <p>Sobald Sie als Benutzer auf unsere Webseite zugreifen oder diese besuchen wird Ihre IP-Adresse, Beginn sowie Beginn und Ende der Sitzung erfasst. Dies ist technisch bedingt und stellt somit ein berechtigtes Interesse iSv Art 6 Abs 1 lit f DSGVO.</p>
        <h5>Kontakt mit uns</h5>
        <p>Wenn Sie uns, entweder über unser Kontaktformular auf unserer Webseite, oder per Email kontaktieren, dann werden die von Ihnen an uns übermittelten Daten zwecks Bearbeitung Ihrer Anfrage oder für den Fall von weiteren Anschlussfragen für sechs Monate bei uns gespeichert. Es erfolgt, ohne Ihre Einwilligung, keine Weitergabe Ihrer übermittelten Daten.</p>
        <h5>Cookies</h5>
        <p>Unsere Website verwendet möglicherweise so genannte Cookies. Dabei handelt es sich um kleine Textdateien, die mit Hilfe des Browsers auf Ihrem Endgerät abgelegt werden. Sie richten keinen Schaden an. Wir nutzen Cookies dazu, unser Angebot nutzerfreundlich zu gestalten. Einige Cookies bleiben auf Ihrem Endgerät gespeichert, bis Sie diese löschen. Sie ermöglichen es uns, Ihren Browser beim nächsten Besuch wiederzuerkennen. Wenn Sie dies nicht wünschen, so können Sie Ihren Browser so einrichten, dass er Sie über das Setzen von Cookies informiert und Sie dies nur im Einzelfall erlauben. Bei der Deaktivierung von Cookies kann die Funktionalität unserer Website eingeschränkt sein.</p>
        <h5>Google Maps</h5>
        <p>Unsere Website verwendet möglicherweise Funktionen des Webkartendienstes „Google Maps“. Der Dienstanbieter dieser Funktion ist:</p>
        <ul>
          <li>Google Ireland Limited Gordon House, Barrow Street Dublin 4. Ireland. Tel: +353 1 543 1000</li>
        </ul>
        <p>Im Zuge der Nutzung von Google Maps ist es notwendig Ihre IP-Adresse zu speichern und zu verarbeiten. Google überträgt in der Regel an einen Server in den USA und speichert die Daten dort. Die Verarbeitung geschieht durch den Diensteanbieter (oben genannt), der Betreiber dieser Homepage hat keinen Einfluss auf die Übertragung der Daten.</p>
        <p>Die Datenverarbeitung erfolgt auf Basis der gesetzlichen Bestimmungen des § 96 Abs 3 TKG sowie des Art 6 Abs 1 lit f (berechtigtes Interesse) der DSGVO. Die Nutzung von Google Maps erhöht die Auffindbarkeit der Orte, welche auf unserer Webseite bereitgestellt werden.</p>
        <p>Weitere Informationen über den Umgang mit Nutzerdaten des Diensteanbieters „Google“ können Sie der Datenschutzerklärung entnehmen:</p>
        <p><a href="https://policies.google.com/privacy?hl=de" target="_blank" rel="noopener noreferrer">https://policies.google.com/privacy?hl=de</a>.</p>
        <p>Google verarbeitet die Daten auch in den USA, hat sich jedoch dem <br /> EU-US Privacy-Shield unterworfen.</p>
        <p><a href="https://www.privacyshield.gov/EU-US-Framework" target="_blank" rel="noopener noreferrer">https://www.privacyshield.gov/EU-US-Framework</a></p>
        <h5>Google Fonts</h5>
        <p>Unsere Website verwendet Schriftarten von „Google Fonts“. Der Dienstanbieter dieser Funktion ist:</p>
        <ul>
          <li>Google Ireland Limited Gordon House, Barrow Street Dublin 4. Ireland</li>
        </ul>
        <p>Tel: +353 1 543 1000</p>
        <p>Beim Aufrufen dieser Webseite lädt Ihr Browser Schriftarten und speichert diese in den Cache. Da Sie, als Besucher der Webseite, Daten des Dienstanbieters empfangen kann Google unter Umständen Cookies auf Ihrem Rechner setzen oder analysieren.</p>
        <p>Die Nutzung von „Google-Fonts“ dient der Optimierung unserer Dienstleistung und der einheitlichen Darstellung von Inhalten. Dies stellt ein berechtigtes Interesse im Sinne von Art. 6 Abs. 1 lit. f DSGVO dar.</p>
        <p>Weitere Informationen zu Google Fonts erhalten Sie unter folgendem Link:</p>
        <ul>
          <li><a href="https://developers.google.com/fonts/faq" target="_blank" rel="noopener noreferrer">https://developers.google.com/fonts/faq</a></li>
        </ul>
        <p>Weitere Informationen über den Umgang mit Nutzerdaten von Google können Sie der Datenschutzerklärung entnehmen:</p>
        <ul>
          <li><a href="https://policies.google.com/privacy?hl=de" target="_blank" rel="noopener noreferrer">https://policies.google.com/privacy?hl=de</a>.</li>
        </ul>
        <p>Google verarbeitet die Daten auch in den USA, hat sich jedoch dem <br /> EU-US Privacy-Shield unterworfen.</p>
        <p><a href="https://www.privacyshield.gov/EU-US-Framework" target="_blank" rel="noopener noreferrer">https://www.privacyshield.gov/EU-US-Framework</a></p>
        <h5>Server-Log Files</h5>
        <p>Diese Webseite und der damit verbundene Provider erhebt möglicherweise im Zuge der Webseitennutzung automatisch Informationen im Rahmen sogenannter „Server-Log Files“. Dies betrifft insbesondere:</p>
        <ul>
          <li>IP-Adresse oder Hostname</li>
          <li>den verwendeten Browser</li>
          <li>Aufenthaltsdauer auf der Webseite sowie Datum und Uhrzeit</li>
          <li>aufgerufene Seiten der Webseite</li>
          <li>Spracheinstellungen und Betriebssystem</li>
          <li>„Leaving-Page“ (auf welcher URL hat der Benutzer die Webseite verlassen)</li>
          <li>ISP (Internet Service Provider)</li>
        </ul>
        <p>Diese erhobenen Informationen werden nicht personenbezogen verarbeitet oder mit personenbezogenen Daten in Verbindung gebracht.</p>
        <p>Der Webseitenbetreiber behält es sich vor, im Falle von Bekanntwerden rechtswidriger Tätigkeiten, diese Daten auszuwerten oder zu überprüfen.</p>
        <h5>Ihre Rechte als Betroffener</h5>
        <p>Sie als Betroffener haben bezüglich Ihrer Daten, welche bei uns gespeichert sind grundsätzlich ein Recht auf:</p>
        <ul>
          <li>Auskunft</li>
          <li>Löschung der Daten</li>
          <li>Berichtigung der Daten</li>
          <li>Übertragbarkeit der Daten</li>
          <li>Wiederruf und Widerspruch zur Datenverarbeitung</li>
          <li>Einschränkung</li>
        </ul>
        <p>Wenn sie vermuten, dass im Zuge der Verarbeitung Ihrer Daten Verstöße gegen das Datenschutzrecht passiert sind, so haben Sie die Möglichkeit sich bei uns (info@grabler.me) oder der Datenschutzbehörde zu beschweren.</p>
        <h5>Sie erreichen uns unter folgenden Kontaktdaten:</h5>
        <p><b>Webseitenbetreiber:</b> Felix Grabler<br /> <b>Telefonnummer:</b> <br /> <b>Email:</b> info@grabler.me</p>
        <p><span>Rechtstext von </span>Quelle: <a href="https://fairesrecht.at/kostenlos-datenschutzerklaerung-erstellen-generator.php" target="_blank" rel="noopener noreferrer">DSGVO Datenschutz Generator</a> in Kooperation mit <b><a href="https://kredit123.at/home" target="_blank" rel="noopener noreferrer">Online Kreditvergleich</a></b></p>
      </section>

      <section v-else-if="isFeedback" class="content-page">
        <h4>Feedback</h4>
        <p class="feedback-note">Danke für dein Feedback. Wir leiten es direkt weiter.</p>

        <form class="feedback-form" @submit.prevent="submitFeedback">
          <label for="category">Kategorie</label>
          <select id="category" v-model="feedback.category" required>
            <option v-for="category in categories" :key="category" :value="category">{{ category }}</option>
          </select>

          <label for="subject">Betreff</label>
          <input id="subject" v-model.trim="feedback.subject" type="text" required maxlength="120" placeholder="Kurzer Titel" />

          <label for="description">Beschreibung</label>
          <textarea id="description" v-model.trim="feedback.description" required rows="8" placeholder="Bitte beschreibe dein Feedback."></textarea>

          <button type="submit" :disabled="isSubmitting">
            {{ isSubmitting ? "Wird gesendet..." : "Feedback senden" }}
          </button>

          <p v-if="submitSuccess" class="feedback-success">Danke! Dein Feedback wurde gesendet.</p>
          <p v-if="submitError" class="feedback-error">{{ submitError }}</p>
        </form>
      </section>

      <section v-else class="content-page not-found">
        <h4>404</h4>
        <img src="/data/404.png" alt="404 - Seite nicht gefunden" class="not-found-image" />
        <button type="button" @click="goBack">Zurück zur vorherigen Seite</button>
      </section>
    </main>

    <footer class="footer">
      <div class="container">
        <div class="footer-links">
          <a href="/">Startseite</a>
          <a href="/impressum">Impressum</a>
          <a href="/dsgvo">DSGVO</a>
          <a href="/feedback">Feedback</a>
        </div>
        <p>&copy; 2026 Felix Grabler. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script>
const CATEGORIES = ['Portfolio', 'Rezepte', 'Namo', 'Fisch', 'Aurena', 'sonstiges']

export default {
  name: 'App',
  data() {
    const felixUrl = 'https://felix.grabler.me'
    const rezepteUrl = 'https://rezepte.grabler.me'
    const namoUrl = 'https://namo.grabler.me'
    const fischUrl = 'https://fisch.grabler.me'
    const krakelUrl = 'https://krakel.grabler.me'

    return {
      currentPath: this.normalizePath(window.location.pathname),
      categories: CATEGORIES,
      feedback: {
        category: 'sonstiges',
        subject: '',
        description: ''
      },
      submitError: '',
      submitSuccess: false,
      isSubmitting: false,
      projects: [
        {
          id: 'felix',
          title: 'Felix Portfolio',
          description: 'My personal portfolio website showcasing my projects, skills, and professional experience. A modern, responsive showcase of my work and expertise.',
          url: felixUrl,
          image: '/data/Felix.jpg'
        },
        {
          id: 'mama-rezepte',
          title: 'Mama-Rezepte',
          description: 'Eine Sammlung von Familienrezepten. Zusätzliche Features wie Filter und Mengenberechnung kommen bald.',
          url: rezepteUrl,
          image: '/data/essen1.jpg'
        },
        {
          id: 'namo',
          title: 'Namo',
          description: 'Eine Seite, um den perfekten Vornamen fürs Kind zu finden. Nach aktuellen Daten aus Österreich, mit Features wie Filter, Vergleich von Stimmen mit einer anderen Person und einigen Spielen.',
          url: namoUrl,
          image: '/data/namo.png'
        },
        {
          id: 'fisch',
          title: 'Fisch',
          description: 'Die Fisch Spaßbude bringt selbst die zertifizierten Fischer an ihre Kenntnisgrenzen. Teste den Fisch in dir, und werde zum Fisch-König.',
          url: fischUrl,
          image: '/data/fisch.jpg'
        },
        {
          id: 'krakel',
          title: 'Krakel',
          description: 'Krakel Orakel kann jeder, auch du!',
          url: krakelUrl,
          image: '/data/krakel.png'
        }
      ]
    }
  },
  computed: {
    isHome() {
      return this.currentPath === '/'
    },
    isImpressum() {
      return this.currentPath === '/impressum'
    },
    isDsgvo() {
      return this.currentPath === '/dsgvo'
    },
    isFeedback() {
      return this.currentPath === '/feedback'
    }
  },
  mounted() {
    if (!this.isFeedback) {
      return
    }

    const source = new URLSearchParams(window.location.search).get('source')
    if (!source) {
      return
    }

    const matchedCategory = this.categories.find((category) => category.toLowerCase() === source.toLowerCase())
    if (matchedCategory) {
      this.feedback.category = matchedCategory
    }
  },
  methods: {
    normalizePath(path) {
      if (!path || path === '/') {
        return '/'
      }

      return path.endsWith('/') ? path.slice(0, -1) : path
    },
    async submitFeedback() {
      this.submitError = ''
      this.submitSuccess = false

      if (!this.feedback.subject || !this.feedback.description) {
        this.submitError = 'Bitte Betreff und Beschreibung ausfüllen.'
        return
      }

      try {
        this.isSubmitting = true
        const response = await fetch('/telegram', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            category: this.feedback.category,
            subject: this.feedback.subject,
            description: this.feedback.description,
            source: new URLSearchParams(window.location.search).get('source') || '',
            page: window.location.href
          })
        })

        if (!response.ok) {
          const payload = await response.json().catch(() => ({}))
          throw new Error(payload.error || 'Senden fehlgeschlagen.')
        }

        this.submitSuccess = true
        this.feedback.subject = ''
        this.feedback.description = ''
      } catch (error) {
        this.submitError = error instanceof Error ? error.message : 'Unbekannter Fehler beim Senden.'
      } finally {
        this.isSubmitting = false
      }
    },
    goBack() {
      if (window.history.length > 1) {
        window.history.back()
        return
      }

      window.location.href = '/'
    }
  }
}
</script>

<style scoped>
.header-inner {
  padding: 60px 0 40px;
}

.content-page {
  background: white;
  border-radius: 12px;
  padding: 28px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  margin: 40px auto;
  line-height: 1.6;
}

.content-page h4 {
  font-size: 2rem;
  margin-bottom: 18px;
}

.content-page a {
  color: #2c3e9f;
}

.feedback-note {
  margin-bottom: 18px;
}

.feedback-form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.feedback-form input,
.feedback-form textarea,
.feedback-form select {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 10px 12px;
  font: inherit;
}

.feedback-form button {
  margin-top: 8px;
  border: none;
  border-radius: 8px;
  background: #1f8f5f;
  color: white;
  font: inherit;
  font-weight: 600;
  padding: 11px 14px;
  cursor: pointer;
}

.feedback-form button:disabled {
  opacity: 0.7;
  cursor: default;
}

.feedback-success {
  color: #127546;
}

.feedback-error {
  color: #b32f2f;
}

.not-found {
  text-align: center;
}

.not-found-image {
  width: 100%;
  max-width: 560px;
  margin: 18px auto;
  display: block;
  border-radius: 10px;
}

.not-found button {
  border: none;
  border-radius: 8px;
  background: #1d4fca;
  color: white;
  font: inherit;
  font-weight: 600;
  padding: 10px 14px;
  cursor: pointer;
}

.footer-links {
  display: flex;
  justify-content: center;
  gap: 12px;
  margin-bottom: 10px;
}

.footer-links a {
  color: white;
}

.project-tile .project-image {
  width: 100% !important;
  height: auto !important;
  aspect-ratio: 1 / 1 !important;
  overflow: hidden;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
}

.project-tile .project-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.project-tile .project-image::before {
  display: none !important;
}
</style>
