# Netlify Deployment Guide

## Quick Start - Choose One Method

**4 Options Available:** Drag-and-Drop (easiest), Netlify CLI (developer), GitHub + Netlify (recommended), Automated Scripts.

### Option 1: Drag-and-Drop (Easiest)
1. Go to [app.netlify.com](https://app.netlify.com)
2. Sign up/login with GitHub, GitLab, or email
3. Drag the entire `xxx Apex Revenue Website` folder onto the Netlify dashboard
4. Netlify will automatically deploy your site
5. Your site will be available at `https://random-name.netlify.app`

### Option 2: Netlify CLI (Recommended for Developers)
```bash
# Install Netlify CLI globally
npm install -g netlify-cli

# Login to Netlify
netlify login

# Initialize and deploy
cd "C:\Users\Don\Documents\Claude\xxx Apex Revenue Website"
netlify init
netlify deploy --prod
```

### Option 3: Connect GitHub Repository
1. Create a GitHub repository
2. Push this project to GitHub
3. Connect Netlify to your GitHub repository
4. Enable auto-deploy

### Option 4: Automated Setup Scripts
We've created two setup scripts to automate the process:

**For Windows (CMD):**
```bash
setup-github.bat
```

**For Unix/macOS/Git Bash:**
```bash
chmod +x setup-github.sh
./setup-github.sh
```

The scripts will:
1. Guide you through entering your GitHub username
2. Set up the git remote
3. Provide step-by-step instructions for creating the repository and deploying to Netlify

## GitHub Repository Setup (for Option 3)

### Create GitHub Repository
```bash
# Create new repository on GitHub (no README, no .gitignore)
# Then connect and push:

cd "C:\Users\Don\Documents\Claude\xxx Apex Revenue Website"
git remote add origin https://github.com/YOUR_USERNAME/apex-physical-therapy.git
git branch -M main
git push -u origin main
```

### Connect Netlify to GitHub
1. In Netlify dashboard: "New site from Git"
2. Select GitHub
3. Authorize Netlify
4. Select your repository (`apex-physical-therapy`)
5. Configure:
   - Build command: (leave empty for static site)
   - Publish directory: `.` (current directory)
6. Click "Deploy site"

## Local Preview

### View Site Locally
```bash
# Open index.html in default browser
cd "C:\Users\Don\Documents\Claude\xxx Apex Revenue Website"
start index.html
```

Or simply double-click `index.html` in File Explorer.

### Local Development Server (Optional)
```bash
# Install live-server
npm install -g live-server

# Start server
cd "C:\Users\Don\Documents\Claude\xxx Apex Revenue Website"
live-server --port=8080
```

## Netlify Configuration

The `netlify.toml` file is already configured with:

- **Publish directory**: `.` (current directory)
- **Redirects**: All routes to index.html for SPA-like behavior
- **Security headers**: XSS protection, content type options
- **Production environment**: Node.js 18

## Custom Domain

After deployment, you can add a custom domain:

1. In Netlify dashboard: Site settings → Domain management
2. Add custom domain (`apexphysicaltherapy.com`)
3. Configure DNS records as instructed by Netlify
4. Enable HTTPS (automatic)

## Form Handling

The contact form currently uses client-side validation. For actual form submissions:

### Option A: Netlify Forms (Free tier: 100 submissions/month)
1. Add `netlify` attribute to form:
   ```html
   <form netlify name="contact" method="POST" data-netlify="true">
   ```
2. Add hidden input for Netlify bots:
   ```html
   <input type="hidden" name="form-name" value="contact">
   ```
3. Redeploy site

### Option B: Formspree/Third-party Service
1. Sign up at [formspree.io](https://formspree.io)
2. Update form `action` URL
3. Configure form fields

## Environment Variables

If you add API keys for image generation:

1. In Netlify dashboard: Site settings → Environment variables
2. Add variables (e.g., `ALIBABA_API_KEY`)
3. Access in JavaScript via `process.env.ALIBABA_API_KEY`

## Auto-Deploy from GitHub

Once connected to GitHub:
- Netlify automatically deploys when you push to `main` branch
- You can set up deploy previews for pull requests
- Rollback to previous deployments if needed

## Monitoring

Netlify provides:
- **Analytics**: Page views, bandwidth
- **Forms**: Submission logs
- **Functions**: Serverless function logs
- **Deploy logs**: Build and deployment history

## Troubleshooting

### Common Issues

1. **Site not loading**: Check if `index.html` is in root directory
2. **CSS/JS not loading**: Verify file paths in HTML
3. **Form not working**: Enable Netlify Forms or check console for errors
4. **Custom domain not working**: Check DNS propagation (can take 24-48 hours)

### Support
- Netlify Docs: [docs.netlify.com](https://docs.netlify.com)
- Netlify Community: [community.netlify.com](https://community.netlify.com)

## Next Steps After Deployment

1. **Test forms**: Submit test contact form
2. **Check responsiveness**: Test on mobile/tablet/desktop
3. **Run Lighthouse audit**: Check performance, accessibility, SEO
4. **Set up analytics**: Google Analytics or Plausible
5. **Configure backups**: Regular commits to GitHub

## Quick Deploy Button

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/YOUR_USERNAME/apex-physical-therapy)

Replace `YOUR_USERNAME` with your GitHub username after creating the repository.