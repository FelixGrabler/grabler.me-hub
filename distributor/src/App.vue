<template>
  <div id="app">
    <header class="header">
      <div class="container">
        <h1>Grabler.me</h1>
        <p>Welcome to my project hub - explore my various applications and tools</p>
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
    return {
      projects: [
        {
          id: 'namo',
          title: 'Namo',
          description: 'A comprehensive name analysis and statistics platform. Explore name popularity, trends, and cultural insights across different countries and time periods.',
          url: 'https://namo.grabler.me',
          icon: '📊',
          gradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          status: 'development'
        }
        // Add more projects here as they become available
        // {
        //   id: 'project2',
        //   title: 'Project 2',
        //   description: 'Description of another project',
        //   url: 'https://project2.grabler.me',
        //   icon: '🚀',
        //   gradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
        //   status: 'live'
        // }
      ]
    }
  }
}
</script>
