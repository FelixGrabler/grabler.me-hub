<template>
  <div id="app">
    <header class="header">
      <div class="container">
        <h1>Grabler.me</h1>
        <p>Willkommen in meinem Projekt-Hub - entdecke meine verschiedenen Websites und Tools</p>
      </div>
    </header>

    <main class="container">
      <div class="projects-grid">
        <a 
          v-for="project in projects" 
          :key="project.id"
          :href="project.url"
          class="project-tile"
          target="_blank"
          rel="noopener noreferrer"
        >
          <div class="project-image" :style="{ background: project.gradient }">
            <span>{{ project.icon }}</span>
          </div>
          <div class="project-content">
            <h3 class="project-title">{{ project.title }}</h3>
            <p class="project-description">{{ project.description }}</p>
            <span class="project-status" :class="project.status">{{ project.status }}</span>
          </div>
        </a>
      </div>
    </main>

    <footer class="footer">
      <div class="container">
        <p>&copy; 2025 Felix Grabler. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    const isDevelopment = import.meta.env.MODE === 'development'
    const baseUrl = isDevelopment ? 'http://localhost:8080' : 'https://grabler.me'
    const felixUrl = isDevelopment ? 'http://felix.localhost:8080' : 'https://felix.grabler.me'
    const rezepteUrl = isDevelopment ? 'http://rezepte.localhost:8080' : 'https://rezepte.grabler.me'
    const namoUrl = isDevelopment ? 'http://namo.localhost:8080' : 'https://namo.grabler.me'
    
    return {
      projects: [
        {
          id: 'felix',
          title: 'Felix Portfolio',
          description: 'My personal portfolio website showcasing my projects, skills, and professional experience. A modern, responsive showcase of my work and expertise.',
          url: felixUrl,
          icon: '�‍💻',
          gradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          status: 'live'
        },
        {
          id: 'mama-rezepte',
          title: 'MamaRezepte',
          description: 'Eine Sammlung von Familienrezepten. Zusätzliche Features wie Filter und Mengenberechnung kommen bald.',
          url: rezepteUrl,
          icon: '👩‍🍳',
          gradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
          status: 'live'
        },
        {
          id: 'namo',
          title: 'Namo',
          description: 'Eine Seite, um den perfekten Vornamen fürs Kind zu finden. Nach aktuellen Daten aus Österreich, mit Features wie Filter, Vergleich von Stimmen mit einer anderen Person und einigen Spielen.',
          url: namoUrl,
          icon: '�',
          gradient: 'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)',
          status: 'development'
        }
      ]
    }
  }
}
</script>
