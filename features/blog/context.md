# Blog/News Feature

## Overview
Create a blog section for publishing physical therapy tips, clinic news, and health education content. This feature includes a blog homepage, individual post pages, and content management via markdown files.

## Goals
1. **Establish Expertise**: Position Apex PT as thought leaders in physical therapy
2. **SEO Enhancement**: Create keyword-rich content to attract organic traffic
3. **Patient Education**: Provide valuable information to current and potential patients
4. **Community Engagement**: Share clinic updates and health tips

## Success Metrics
- **Traffic Growth**: Increase organic search traffic by 30% within 6 months
- **Engagement**: Average time on blog pages > 3 minutes
- **Conversions**: 10% of blog visitors submit contact forms
- **Social Shares**: Average 5 shares per blog post
- **Newsletter Signups**: Capture emails from 5% of blog visitors

## Implementation Notes
### Architecture
1. **Static Blog Generator**:
   - Markdown-based content storage in `blog/posts/`
   - Build script to generate HTML pages
   - No database or server-side processing needed

2. **Blog Homepage** (`blog.html`):
   - List of recent posts with excerpts
   - Category filtering
   - Search functionality
   - Newsletter signup form

3. **Individual Post Pages** (`blog/post-slug.html`):
   - Full blog post content
   - Author bio
   - Related posts
   - Social sharing buttons
   - Comments section (optional)

### Content Strategy
- **Weekly Posts**: 1-2 posts per week
- **Categories**: Rehabilitation Tips, Injury Prevention, Clinic News, Patient Stories
- **Post Length**: 800-1500 words with images
- **SEO Focus**: Target local keywords ("physical therapy Rocky Hill", "sports injury treatment CT")

### Technical Requirements
- **Markdown Processing**: Use a lightweight library or custom parser
- **RSS Feed**: Generate RSS feed for subscribers
- **Sitemap Integration**: Update sitemap.xml with blog posts
- **Social Meta Tags**: Open Graph and Twitter cards for each post

### Integration Points
- Add blog link to main navigation
- Feature latest posts on homepage
- Integrate with Netlify CMS for content management (future)
- Add newsletter signup forms

## Dependencies
- Content creation process and schedule
- Blog post images and graphics
- Markdown processing library (optional)
- RSS feed generator

## Files to Create/Modify
1. `blog.html` - Blog homepage
2. `blog/` directory structure for posts
3. `css/blog.css` - Blog-specific styles
4. `js/blog.js` - Blog functionality
5. `build-blog.js` - Static site generator script
6. Update `index.html` - Add blog section/latest posts
7. Update all navigation menus

## Validation Checklist
- [ ] All blog posts render correctly
- [ ] RSS feed is valid
- [ ] SEO meta tags are properly set
- [ ] Social sharing works
- [ ] Search functionality works
- [ ] Newsletter form integrates with email service
- [ ] Mobile responsive design
- [ ] Page load under 3 seconds