#!/bin/bash

# Testimonials Feature Startup Script
# Creates necessary files and directories for testimonials feature

set -e  # Exit on error

echo "🚀 Starting Testimonials Feature Setup..."
echo "========================================="

# Create testimonial data directory
mkdir -p data/testimonials
echo "📁 Created data/testimonials directory"

# Create testimonial images directory
mkdir -p images/testimonials
echo "📁 Created images/testimonials directory"

# Create testimonials HTML page
cat > testimonials.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apex Physical Therapy | Patient Testimonials</title>
    <meta name="description" content="Read patient success stories and testimonials from Apex Physical Therapy in Rocky Hill, CT.">

    <!-- Head content same as other pages -->
</head>
<body class="page-transition">
    <!-- Navigation same as other pages -->

    <section class="hero-container">
        <div class="hero-bg medical-pattern"></div>
        <div class="container hero-content">
            <h1 class="hero-title">
                <span class="text-gradient">Patient Success Stories</span><br>
                <span class="text-slate">Real Results from Real Patients</span>
            </h1>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div id="testimonials-container" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Testimonials will be loaded by JavaScript -->
                <div class="text-center py-12">
                    <div class="loading"></div>
                    <p class="mt-4">Loading testimonials...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer same as other pages -->

    <script src="js/testimonials.js"></script>
</body>
</html>
EOF
echo "📄 Created testimonials.html template"

# Create testimonials JavaScript file
cat > js/testimonials.js << 'EOF'
// Testimonials Feature JavaScript
document.addEventListener('DOMContentLoaded', function() {
    const testimonials = [
        {
            id: 1,
            name: "John D.",
            condition: "Knee Replacement Recovery",
            rating: 5,
            text: "The team at Apex helped me regain mobility after my knee surgery. I'm back to walking my dog daily!",
            date: "2024-03-15",
            service: "post-surgical"
        },
        // Add more testimonial objects here
    ];

    const container = document.getElementById('testimonials-container');

    if (container) {
        renderTestimonials(testimonials);
    }

    function renderTestimonials(testimonialsArray) {
        container.innerHTML = '';

        testimonialsArray.forEach(testimonial => {
            const card = createTestimonialCard(testimonial);
            container.appendChild(card);
        });
    }

    function createTestimonialCard(testimonial) {
        const card = document.createElement('div');
        card.className = 'glass-card p-6 testimonial-card';

        // Create star rating
        let stars = '';
        for (let i = 0; i < 5; i++) {
            stars += i < testimonial.rating ? '★' : '☆';
        }

        card.innerHTML = `
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 rounded-full bg-cyan/20 flex items-center justify-center mr-4">
                    <span class="text-xl">👤</span>
                </div>
                <div>
                    <h3 class="font-semibold">${testimonial.name}</h3>
                    <p class="text-sm text-gray-600">${testimonial.condition}</p>
                </div>
            </div>
            <div class="text-yellow-500 mb-4">${stars}</div>
            <p class="mb-4 italic">"${testimonial.text}"</p>
            <div class="flex justify-between items-center text-sm text-gray-500">
                <span>${testimonial.service}</span>
                <span>${testimonial.date}</span>
            </div>
        `;

        return card;
    }
});
EOF
echo "📄 Created js/testimonials.js"

# Add CSS for testimonials to components.css
echo "📝 Note: Add testimonial styles to css/components.css:"
echo "
/* Testimonial Cards */
.testimonial-card {
    transition: transform 0.3s ease;
}
.testimonial-card:hover {
    transform: translateY(-4px);
}
"

echo "✅ Testimonials feature setup complete!"
echo ""
echo "Next steps:"
echo "1. Add actual patient testimonials to js/testimonials.js"
echo "2. Add testimonial styles to css/components.css"
echo "3. Update navigation menus to include testimonials link"
echo "4. Test the page locally"
echo ""
echo "Run './final.sh' when feature is complete."