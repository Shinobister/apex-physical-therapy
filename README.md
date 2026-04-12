# Apex Physical Therapy Website

A high-performance, responsive website for Apex Physical Therapy in Rocky Hill, CT. Built with the "High-Transparency Clinical Minimalism" aesthetic featuring glassmorphism effects and a mobile-first approach.

## Features

- **High-Transparency Clinical Minimalism** design aesthetic
- **Glassmorphism** UI elements with backdrop blur effects
- **Mobile-first** responsive design
- **Smooth scrolling** and interactive components
- **Accessibility** focused with ARIA labels and keyboard navigation
- **Performance optimized** with lazy loading and modern CSS
- **Contact form** with real-time validation

## Design Specifications

### Color Palette
- Medical Cyan: `#00CED1` (primary action color)
- Deep Slate Blue: `#2F4F4F` (primary typography)
- Soft Mint: `#E0F2F1` (section backgrounds)

### Typography
- Primary: Inter (sans-serif)
- Secondary: Poppins (headings)

### Glassmorphism Effects
```css
.glass-card {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}
```

## Project Structure

```
apex-physical-therapy/
├── index.html          # Landing page
├── services.html       # Services page
├── portal.html         # Patient portal
├── contact.html        # Contact page
├── css/
│   ├── variables.css   # Design tokens
│   ├── base.css        # Reset & base styles
│   ├── layout.css      # Grid & flex utilities
│   ├── components.css  # UI components
│   ├── responsive.css  # Media queries
│   └── style.css       # Main stylesheet
├── js/
│   ├── main.js         # Core functionality
│   ├── form.js         # Form handling
│   └── gallery.js      # Image gallery
├── images/             # Website assets
├── assets/             # PDFs & documents
└── README.md           # This file
```

## Pages

### 1. Landing Page (index.html)
- Hero section with "Restore Functional Independence"
- Service grid (Orthopedics, Sports Medicine, Manual Therapy)
- Smart Loading philosophy section
- Doctor spotlight (Dr. Anand Bishnoi)
- Contact information and map

### 2. Services Page (services.html)
- Detailed service descriptions
- Interactive accordions
- Treatment protocols
- Insurance information

### 3. Patient Portal (portal.html)
- Resource library with PDF downloads
- FAQ section
- Online forms
- Appointment scheduling

### 4. Contact Page (contact.html)
- Contact form with validation
- Interactive map
- Clinic hours and location
- Emergency contact information

## JavaScript Functionality

### Core Features
- Mobile menu toggle
- Smooth scrolling navigation
- Scroll progress indicator
- Active link highlighting
- Accordion interactions
- Form validation
- Lazy loading images
- Parallax effects

### Form Handling
- Real-time validation
- Success/error feedback
- Accessibility features
- Spam prevention

## Performance Optimizations

- **CSS Grid/Flexbox** for layout
- **CSS Custom Properties** for theming
- **Lazy loading** for images
- **Minimal JavaScript** footprint
- **Critical CSS** inlined
- **Font subsetting** for faster loading
- **Image optimization** (WebP format)

## Browser Support

- Chrome 90+
- Safari 14+
- Firefox 88+
- Edge 90+
- Mobile Safari (iOS 14+)
- Chrome for Android

## Development

### Local Development
```bash
# Clone repository
git clone https://github.com/username/apex-physical-therapy.git

# Open in browser
open index.html
```

### Build Process
This is a static website with no build process required. Files are ready to deploy.

## Deployment

### GitHub Pages
1. Push to GitHub repository
2. Go to Settings → Pages
3. Set source to `main` branch
4. Site will be available at `https://username.github.io/apex-physical-therapy`

### Custom Domain
1. Add `CNAME` file with domain name
2. Configure DNS records to point to GitHub Pages
3. Enable HTTPS in GitHub Pages settings

## AI Image Generation

The website uses AI-generated images created with:
- **Model**: Qwen-VL (Alibaba Cloud)
- **Cost**: ~$0.03 per image
- **Style**: "High-Transparency Clinical Minimalism"
- **Content**: Clinic interiors, doctor portraits, medical icons

### Image Prompts
```
"Modern physical therapy clinic interior with natural sunlight, minimalist design, medical cyan accents, empty treatment room with professional equipment"
"Professional Asian male doctor in white coat with teal tie, friendly confident expression, clinical office background"
"Minimalist line art icon of human joints for orthopedics, medical cyan color, clean simple design"
```

## Accessibility

- WCAG 2.1 AA compliant
- Keyboard navigation support
- Screen reader optimized
- High contrast mode support
- Reduced motion preferences
- Focus management

## SEO

- Semantic HTML structure
- Meta tags and Open Graph
- Structured data (Schema.org)
- XML sitemap
- Robots.txt
- Canonical URLs

## Analytics

Google Analytics integration included in the footer. To enable:
1. Replace `GA_MEASUREMENT_ID` in `index.html`
2. Update tracking code in Google Analytics

## License

All rights reserved. This website is proprietary to Apex Physical Therapy.

## Credits

- Design: "High-Transparency Clinical Minimalism" aesthetic
- Development: Claude Code AI Assistant
- Images: AI-generated with Qwen-VL
- Icons: Custom minimalist line art
- Fonts: Google Fonts (Inter, Poppins)

## Contact

Apex Physical Therapy  
825 Cromwell Ave, Suite Q  
Rocky Hill, CT 06067  
(860) 555-0123  
info@apexphysicaltherapy.com# apex-physical-therapy
