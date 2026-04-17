#!/bin/bash

# Appointment Scheduling Feature Startup Script
# Creates scheduling structure and template files

set -e

echo "🚀 Starting Appointment Scheduling Setup..."
echo "============================================"

# Create scheduling directories
mkdir -p js/scheduling
mkdir -p css/scheduling
echo "📁 Created scheduling directory structure"

# Create scheduling page
cat > scheduling.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment | Apex Physical Therapy</title>
    <meta name="description" content="Book your physical therapy appointment online with Apex Physical Therapy in Rocky Hill, CT. Easy scheduling, real-time availability.">

    <!-- Head content same as other pages -->
</head>
<body class="page-transition">
    <!-- Navigation same as other pages -->

    <section class="hero-container">
        <div class="hero-bg medical-pattern"></div>
        <div class="container hero-content">
            <h1 class="hero-title">
                <span class="text-gradient">Book Your Appointment</span><br>
                <span class="text-slate">Easy Online Scheduling 24/7</span>
            </h1>
            <p class="hero-subtitle max-w-2xl">
                Schedule your initial consultation or follow-up appointment with our physical therapists.
                Choose your preferred time, service, and therapist.
            </p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Scheduling widget -->
                <div class="lg:col-span-2">
                    <div class="glass-card p-6">
                        <h2 class="text-2xl mb-6">Schedule Your Appointment</h2>

                        <!-- Calendly embed or custom scheduling widget -->
                        <div id="scheduling-widget" class="min-h-[600px]">
                            <div class="text-center py-12">
                                <div class="loading"></div>
                                <p class="mt-4">Loading scheduling options...</p>
                            </div>
                        </div>

                        <div class="mt-8 p-4 bg-cyan/10 rounded-lg">
                            <h3 class="text-lg mb-2">Need Help Scheduling?</h3>
                            <p class="text-sm">Call us at <strong>(860) 555-0123</strong> or <a href="contact.html" class="text-cyan hover:underline">send us a message</a>.</p>
                        </div>
                    </div>
                </div>

                <!-- Scheduling info sidebar -->
                <div class="lg:col-span-1">
                    <div class="glass-card p-6 mb-8">
                        <h3 class="text-xl mb-4">What to Expect</h3>
                        <ul class="space-y-3">
                            <li class="flex items-start">
                                <span class="text-cyan mr-2">✓</span>
                                <span><strong>Initial Evaluation</strong>: 60-minute comprehensive assessment</span>
                            </li>
                            <li class="flex items-start">
                                <span class="text-cyan mr-2">✓</span>
                                <span><strong>Follow-up Sessions</strong>: 45-minute treatment sessions</span>
                            </li>
                            <li class="flex items-start">
                                <span class="text-cyan mr-2">✓</span>
                                <span><strong>Insurance Verification</strong>: We'll verify your coverage</span>
                            </li>
                            <li class="flex items-start">
                                <span class="text-cyan mr-2">✓</span>
                                <span><strong>Paperwork</strong>: Complete forms before your visit</span>
                            </li>
                        </ul>
                    </div>

                    <div class="glass-card p-6">
                        <h3 class="text-xl mb-4">Our Services</h3>
                        <ul class="space-y-2">
                            <li><a href="services.html#orthopedic" class="hover:text-cyan">Orthopedic Physical Therapy</a></li>
                            <li><a href="services.html#sports" class="hover:text-cyan">Sports Injury Rehabilitation</a></li>
                            <li><a href="services.html#post-surgical" class="hover:text-cyan">Post-Surgical Rehabilitation</a></li>
                            <li><a href="services.html#balance" class="hover:text-cyan">Balance & Fall Prevention</a></li>
                            <li><a href="services.html#pain" class="hover:text-cyan">Chronic Pain Management</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer same as other pages -->

    <script src="js/scheduling.js"></script>
</body>
</html>
EOF
echo "📄 Created scheduling.html"

# Create scheduling JavaScript
cat > js/scheduling.js << 'EOF'
// Appointment Scheduling JavaScript

document.addEventListener('DOMContentLoaded', function() {
    const schedulingWidget = document.getElementById('scheduling-widget');

    if (!schedulingWidget) return;

    // Initialize scheduling widget
    initializeSchedulingWidget();

    function initializeSchedulingWidget() {
        // For now, show a placeholder with integration instructions
        // In production, this would embed Calendly or another scheduling service

        schedulingWidget.innerHTML = `
            <div class="p-8 text-center">
                <div class="w-24 h-24 mx-auto mb-6 rounded-full bg-cyan/20 flex items-center justify-center">
                    <span class="text-4xl">📅</span>
                </div>

                <h3 class="text-xl mb-4">Online Scheduling Integration</h3>
                <p class="mb-6 text-gray-700">
                    This area will display the scheduling widget from Calendly, Acuity, or your preferred scheduling platform.
                </p>

                <div class="bg-gray-50 p-6 rounded-lg text-left mb-6">
                    <h4 class="font-semibold mb-3">Integration Options:</h4>
                    <ul class="space-y-2 text-sm">
                        <li><strong>Calendly</strong>: Embed code for scheduling widget</li>
                        <li><strong>Acuity Scheduling</strong>: Square's appointment platform</li>
                        <li><strong>SimplyBook.me</strong>: Feature-rich booking system</li>
                        <li><strong>Custom Solution</strong>: Build your own scheduling system</li>
                    </ul>
                </div>

                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="https://calendly.com/" target="_blank" class="btn btn-primary">
                        Set Up Calendly
                    </a>
                    <a href="contact.html" class="btn btn-outline">
                        Contact Us for Help
                    </a>
                </div>
            </div>
        `;
    }

    // Add event listeners for service selection
    const serviceLinks = document.querySelectorAll('a[href^="services.html"]');
    serviceLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (this.hash) {
                // Store selected service for scheduling
                localStorage.setItem('selectedService', this.hash.substring(1));
            }
        });
    });

    // Check for pre-selected service
    const urlParams = new URLSearchParams(window.location.search);
    const service = urlParams.get('service');
    if (service) {
        // Highlight or pre-select the service in the scheduling widget
        console.log('Pre-selected service:', service);
    }
});
EOF
echo "📄 Created js/scheduling.js"

# Create scheduling CSS
cat > css/scheduling.css << 'EOF'
/* Scheduling-specific styles */

#scheduling-widget {
    border-radius: var(--border-radius-lg);
    overflow: hidden;
}

.service-option {
    border: 2px solid var(--light-gray);
    border-radius: var(--border-radius-md);
    padding: 1.5rem;
    transition: all 0.3s ease;
    cursor: pointer;
}

.service-option:hover {
    border-color: var(--medical-cyan);
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

.service-option.selected {
    border-color: var(--medical-cyan);
    background-color: rgba(0, 206, 209, 0.05);
}

.time-slot {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    border: 1px solid var(--medium-gray);
    border-radius: var(--border-radius-md);
    margin: 0.25rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.time-slot:hover {
    background-color: var(--light-gray);
}

.time-slot.selected {
    background-color: var(--medical-cyan);
    color: white;
    border-color: var(--medical-cyan);
}

.therapist-card {
    text-align: center;
    padding: 1.5rem;
    border-radius: var(--border-radius-md);
    border: 1px solid var(--light-gray);
    transition: all 0.3s ease;
}

.therapist-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-md);
}

.therapist-avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin: 0 auto 1rem;
    background-color: var(--light-gray);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
}

.scheduling-step {
    display: flex;
    align-items: center;
    margin-bottom: 2rem;
}

.step-number {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: var(--medical-cyan);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 1rem;
    flex-shrink: 0;
}

.step-content {
    flex: 1;
}

.step-title {
    font-weight: 600;
    margin-bottom: 0.25rem;
}

.step-description {
    color: var(--dark-gray);
    font-size: 0.9rem;
}
EOF
echo "📄 Created css/scheduling.css"

echo "✅ Appointment scheduling setup complete!"
echo ""
echo "Next steps:"
echo "1. Sign up for a scheduling service (Calendly, Acuity, etc.)"
echo "2. Get embed code and update js/scheduling.js"
echo "3. Configure therapist availability and services"
echo "4. Test the scheduling flow end-to-end"
echo "5. Update navigation menus to include scheduling link"
echo ""
echo "Run './final.sh' when feature is complete."
EOF
echo "📄 Created features/appointment-scheduling/startup.sh"

echo "✅ Appointment scheduling startup script created!"