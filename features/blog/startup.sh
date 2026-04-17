#!/bin/bash

# Blog Feature Startup Script
# Creates blog structure and template files

set -e

# If running from within features directory, change to project root
if [[ "$PWD" == *"/features/"* ]]; then
    cd "$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD/../..")"
fi

echo "🚀 Starting Blog Feature Setup..."
echo "================================="

# Create blog directories
mkdir -p blog/posts
mkdir -p blog/images
mkdir -p blog/css
echo "📁 Created blog directory structure"

# Create blog homepage
cat > blog.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apex Physical Therapy | Blog & Health Tips</title>
    <meta name="description" content="Physical therapy tips, injury prevention advice, and clinic news from Apex Physical Therapy in Rocky Hill, CT.">

    <!-- Head content same as other pages -->
</head>
<body class="page-transition">
    <!-- Navigation same as other pages -->

    <section class="hero-container">
        <div class="hero-bg medical-pattern"></div>
        <div class="container hero-content">
            <h1 class="hero-title">
                <span class="text-gradient">Health & Wellness Blog</span><br>
                <span class="text-slate">Expert Tips from Our Physical Therapists</span>
            </h1>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Main content -->
                <div class="lg:col-span-2">
                    <div id="blog-posts" class="space-y-8">
                        <!-- Blog posts will be loaded here -->
                        <div class="text-center py-12">
                            <div class="loading"></div>
                            <p class="mt-4">Loading blog posts...</p>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="lg:col-span-1">
                    <div class="glass-card p-6 mb-8">
                        <h3 class="text-xl mb-4">Subscribe to Our Newsletter</h3>
                        <form id="newsletter-form" class="space-y-4">
                            <input type="email" placeholder="Your email" class="form-control" required>
                            <button type="submit" class="btn btn-primary btn-full">Subscribe</button>
                        </form>
                    </div>

                    <div class="glass-card p-6">
                        <h3 class="text-xl mb-4">Categories</h3>
                        <div id="blog-categories" class="space-y-2">
                            <!-- Categories will be loaded here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer same as other pages -->

    <script src="js/blog.js"></script>
</body>
</html>
EOF
echo "📄 Created blog.html"

# Create blog CSS
mkdir -p css
cat > css/blog.css << 'EOF'
/* Blog-specific styles */

.blog-post {
    margin-bottom: 3rem;
    border-bottom: 1px solid var(--medium-gray);
    padding-bottom: 2rem;
}

.blog-post:last-child {
    border-bottom: none;
}

.post-title {
    font-size: var(--text-2xl);
    margin-bottom: 1rem;
}

.post-meta {
    color: var(--dark-gray);
    font-size: var(--text-sm);
    margin-bottom: 1rem;
}

.post-excerpt {
    font-size: var(--text-base);
    line-height: 1.6;
    margin-bottom: 1.5rem;
}

.read-more {
    color: var(--medical-cyan);
    font-weight: 600;
}

.post-content {
    line-height: 1.8;
}

.post-content h2 {
    font-size: var(--text-xl);
    margin: 2rem 0 1rem;
}

.post-content h3 {
    font-size: var(--text-lg);
    margin: 1.5rem 0 0.75rem;
}

.post-content img {
    max-width: 100%;
    height: auto;
    border-radius: var(--border-radius-md);
    margin: 1.5rem 0;
}

.post-content blockquote {
    border-left: 4px solid var(--medical-cyan);
    padding-left: 1.5rem;
    margin: 1.5rem 0;
    font-style: italic;
    color: var(--dark-gray);
}

.category-tag {
    display: inline-block;
    background-color: rgba(0, 206, 209, 0.1);
    color: var(--medical-cyan);
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    font-size: var(--text-sm);
    margin-right: 0.5rem;
    margin-bottom: 0.5rem;
}
EOF
echo "📄 Created css/blog.css"

# Create blog JavaScript
mkdir -p js
cat > js/blog.js << 'EOF'
// Blog Feature JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Sample blog data - in production, this would come from markdown files
    const blogPosts = [
        {
            id: 1,
            slug: 'preventing-running-injuries',
            title: '5 Tips for Preventing Running Injuries',
            excerpt: 'Learn how to protect yourself from common running injuries with these expert tips from our physical therapists.',
            content: 'Full blog post content here...',
            author: 'Dr. Sarah Johnson',
            date: '2024-04-10',
            category: 'Injury Prevention',
            readTime: '4 min read',
            image: 'images/blog/running-tips.jpg'
        },
        // Add more posts here
    ];

    const postsContainer = document.getElementById('blog-posts');
    const categoriesContainer = document.getElementById('blog-categories');

    if (postsContainer) {
        renderBlogPosts(blogPosts);
    }

    if (categoriesContainer) {
        renderCategories(blogPosts);
    }

    function renderBlogPosts(posts) {
        postsContainer.innerHTML = '';

        posts.forEach(post => {
            const postElement = createBlogPostElement(post);
            postsContainer.appendChild(postElement);
        });
    }

    function createBlogPostElement(post) {
        const article = document.createElement('article');
        article.className = 'blog-post';

        article.innerHTML = `
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 rounded-full bg-cyan/20 flex items-center justify-center mr-4">
                    <span class="text-xl">📝</span>
                </div>
                <div>
                    <h2 class="post-title">${post.title}</h2>
                    <div class="post-meta">
                        <span>${post.author} • ${post.date} • ${post.readTime}</span>
                        <span class="category-tag">${post.category}</span>
                    </div>
                </div>
            </div>
            <p class="post-excerpt">${post.excerpt}</p>
            <a href="blog/${post.slug}.html" class="read-more">Read More →</a>
        `;

        return article;
    }

    function renderCategories(posts) {
        // Extract unique categories
        const categories = [...new Set(posts.map(post => post.category))];

        categoriesContainer.innerHTML = '';

        categories.forEach(category => {
            const button = document.createElement('button');
            button.className = 'block w-full text-left p-2 hover:bg-gray-100 rounded';
            button.textContent = category;
            button.addEventListener('click', () => filterByCategory(category));
            categoriesContainer.appendChild(button);
        });
    }

    function filterByCategory(category) {
        const filteredPosts = blogPosts.filter(post => post.category === category);
        renderBlogPosts(filteredPosts);
    }

    // Newsletter form handling
    const newsletterForm = document.getElementById('newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            // In production, integrate with email service
            alert('Thank you for subscribing! Check your email to confirm.');
            this.reset();
        });
    }
});
EOF
echo "📄 Created js/blog.js"

# Create a sample blog post template
cat > blog/posts/template.md << 'EOF'
---
title: "Blog Post Title"
date: YYYY-MM-DD
author: "Author Name"
category: "Category"
excerpt: "Brief excerpt of the blog post"
image: "images/blog/image.jpg"
readTime: "X min read"
---

# Blog Post Title

Start your blog post content here...

## Subheading

More content...

### Key Points
- Point 1
- Point 2
- Point 3

> Important quote or tip

**Bold text** and *italic text*.

[Link text](https://example.com)

![Alt text](image.jpg)
EOF
echo "📄 Created blog/posts/template.md"

echo "✅ Blog feature setup complete!"
echo ""
echo "Next steps:"
echo "1. Add actual blog posts as markdown files in blog/posts/"
echo "2. Create a build script to generate HTML from markdown"
echo "3. Update navigation menus to include blog link"
echo "4. Integrate with an email newsletter service"
echo "5. Test the blog functionality"
echo ""
echo "Run './final.sh' when feature is complete."