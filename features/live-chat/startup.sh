#!/bin/bash

# Live Chat Feature Startup Script
# Creates chat configuration and template files

set -e

echo "🚀 Starting Live Chat Setup..."
echo "==============================="

# Create chat directories
mkdir -p js/chat
mkdir -p css/chat
echo "📁 Created chat directory structure"

# Create chat configuration JavaScript
cat > js/chat-config.js << 'EOF'
// Live Chat Configuration
// Customize chat widget behavior and appearance

document.addEventListener('DOMContentLoaded', function() {
    // Chat configuration object
    window.chatConfig = {
        // Business hours configuration (Eastern Time)
        businessHours: {
            enabled: true,
            timezone: 'America/New_York',
            schedule: {
                monday: { start: '9:00', end: '17:00' },
                tuesday: { start: '9:00', end: '17:00' },
                wednesday: { start: '9:00', end: '17:00' },
                thursday: { start: '9:00', end: '17:00' },
                friday: { start: '9:00', end: '17:00' },
                saturday: { start: '9:00', end: '13:00' },
                sunday: { start: null, end: null } // Closed
            }
        },

        // Chat widget appearance
        appearance: {
            primaryColor: '#00CED1', // Medical cyan
            widgetPosition: 'bottom-right',
            showOnMobile: true,
            desktopWidth: 380,
            mobileWidth: '100%',
            zIndex: 10000
        },

        // Automated messages
        messages: {
            greeting: "Hello! 👋 Welcome to Apex Physical Therapy. How can we help you today?",
            offline: "Thanks for reaching out! Our team is currently offline. Please leave a message and we'll get back to you during business hours.",
            businessHours: "We're here to help! Our team is available Mon-Fri 9am-5pm, Sat 9am-1pm ET.",
            quickReplies: [
                "Book an appointment",
                "Insurance questions",
                "Directions to clinic",
                "Physical therapy services",
                "Speak with a therapist"
            ]
        },

        // Staff configuration
        staff: {
            operators: [
                { name: "Front Desk", role: "Scheduling & General Inquiries" },
                { name: "Therapist", role: "Clinical Questions" },
                { name: "Billing", role: "Insurance & Payment Questions" }
            ],
            autoAssign: true,
            offlineHandling: 'form'
        },

        // Analytics and tracking
        analytics: {
            trackConversions: true,
            monitorResponseTime: true,
            exportChatHistory: true
        }
    };

    // Initialize chat widget
    initializeChatWidget();
});

function initializeChatWidget() {
    console.log('Initializing chat widget with config:', window.chatConfig);

    // Check if within business hours
    const isBusinessHours = checkBusinessHours();

    // Create chat widget container
    const chatContainer = document.createElement('div');
    chatContainer.id = 'apex-chat-widget';
    chatContainer.className = 'chat-widget-container';
    document.body.appendChild(chatContainer);

    // For now, show a placeholder with integration instructions
    // In production, this would initialize Tawk.to, Crisp, or another chat service

    renderChatPlaceholder(chatContainer, isBusinessHours);
}

function checkBusinessHours() {
    const config = window.chatConfig.businessHours;
    if (!config.enabled) return true;

    const now = new Date();
    const day = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'][now.getDay()];
    const schedule = config.schedule[day];

    if (!schedule.start || !schedule.end) return false;

    // Simple time check - in production, use proper timezone conversion
    const currentHour = now.getHours();
    const currentMinute = now.getMinutes();

    const [startHour, startMinute] = schedule.start.split(':').map(Number);
    const [endHour, endMinute] = schedule.end.split(':').map(Number);

    const currentTime = currentHour * 60 + currentMinute;
    const startTime = startHour * 60 + startMinute;
    const endTime = endHour * 60 + endMinute;

    return currentTime >= startTime && currentTime <= endTime;
}

function renderChatPlaceholder(container, isBusinessHours) {
    container.innerHTML = `
        <div class="chat-placeholder">
            <div class="chat-header">
                <div class="status-indicator ${isBusinessHours ? 'online' : 'offline'}"></div>
                <span class="status-text">${isBusinessHours ? 'Live Chat Available' : 'Currently Offline'}</span>
            </div>

            <div class="chat-content">
                <div class="text-center p-6">
                    <div class="w-16 h-16 mx-auto mb-4 rounded-full bg-cyan/20 flex items-center justify-center">
                        <span class="text-2xl">💬</span>
                    </div>

                    <h3 class="text-lg font-semibold mb-2">Live Chat Integration</h3>
                    <p class="text-gray-600 mb-4">
                        This area will display the live chat widget from Tawk.to, Crisp, or your preferred chat service.
                    </p>

                    <div class="bg-gray-50 p-4 rounded-lg text-left mb-4">
                        <h4 class="font-semibold mb-2">Configuration Needed:</h4>
                        <ul class="space-y-1 text-sm">
                            <li>1. Sign up for a chat service account</li>
                            <li>2. Get the embed JavaScript code</li>
                            <li>3. Replace this placeholder with actual widget</li>
                            <li>4. Configure business hours and auto-responses</li>
                            <li>5. Set up staff notifications</li>
                        </ul>
                    </div>

                    <div class="flex flex-col sm:flex-row gap-2 justify-center">
                        <a href="https://tawk.to/" target="_blank" class="btn btn-primary btn-sm">
                            Set Up Tawk.to
                        </a>
                        <a href="https://crisp.chat/" target="_blank" class="btn btn-outline btn-sm">
                            Set Up Crisp
                        </a>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Utility function to show/hide chat based on business hours
function toggleChatVisibility(show) {
    const widget = document.getElementById('apex-chat-widget');
    if (widget) {
        widget.style.display = show ? 'block' : 'none';
    }
}
EOF
echo "📄 Created js/chat-config.js"

# Create chat widget CSS
cat > css/chat-widget.css << 'EOF'
/* Live Chat Widget Styles */

.chat-widget-container {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 380px;
    max-width: calc(100vw - 40px);
    z-index: 10000;
    font-family: var(--font-sans);
}

.chat-placeholder {
    background: white;
    border-radius: var(--border-radius-lg);
    box-shadow: var(--shadow-xl);
    overflow: hidden;
    border: 1px solid var(--light-gray);
}

.chat-header {
    background: var(--medical-cyan);
    color: white;
    padding: 1rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.status-indicator {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    margin-right: 0.5rem;
}

.status-indicator.online {
    background-color: #10B981;
    animation: pulse 2s infinite;
}

.status-indicator.offline {
    background-color: #6B7280;
}

.status-text {
    font-weight: 600;
    font-size: 0.9rem;
}

.chat-content {
    max-height: 500px;
    overflow-y: auto;
}

.chat-message {
    padding: 1rem;
    margin: 0.5rem;
    border-radius: var(--border-radius-md);
    max-width: 80%;
}

.chat-message.user {
    background-color: var(--medical-cyan);
    color: white;
    margin-left: auto;
}

.chat-message.agent {
    background-color: var(--light-gray);
    color: var(--text-color);
    margin-right: auto;
}

.chat-input-area {
    border-top: 1px solid var(--light-gray);
    padding: 1rem;
}

.chat-input {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid var(--medium-gray);
    border-radius: var(--border-radius-md);
    font-size: 0.9rem;
    margin-bottom: 0.5rem;
}

.chat-input:focus {
    outline: none;
    border-color: var(--medical-cyan);
    box-shadow: 0 0 0 3px rgba(0, 206, 209, 0.1);
}

.quick-replies {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-top: 0.5rem;
}

.quick-reply {
    background-color: var(--light-gray);
    border: 1px solid var(--medium-gray);
    border-radius: 1rem;
    padding: 0.375rem 0.75rem;
    font-size: 0.8rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.quick-reply:hover {
    background-color: var(--medical-cyan);
    color: white;
    border-color: var(--medical-cyan);
}

.chat-toggle {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background-color: var(--medical-cyan);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: var(--shadow-lg);
    cursor: pointer;
    z-index: 9999;
    border: none;
    transition: all 0.3s ease;
}

.chat-toggle:hover {
    transform: scale(1.1);
    box-shadow: var(--shadow-xl);
}

.chat-toggle .badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background-color: #EF4444;
    color: white;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    font-size: 0.7rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

@keyframes pulse {
    0% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
    100% {
        opacity: 1;
    }
}

/* Mobile styles */
@media (max-width: 640px) {
    .chat-widget-container {
        width: calc(100vw - 40px);
        max-width: none;
        bottom: 10px;
        right: 10px;
        left: 10px;
    }

    .chat-toggle {
        bottom: 10px;
        right: 10px;
        width: 50px;
        height: 50px;
    }
}
EOF
echo "📄 Created css/chat-widget.css"

# Create installation instructions
cat > chat-installation.md << 'EOF'
# Live Chat Installation Guide

## Step 1: Choose a Chat Service
Recommended options:
1. **Tawk.to** (Free) - https://tawk.to/
2. **Crisp Chat** (Freemium) - https://crisp.chat/
3. **HubSpot Live Chat** (Paid) - https://www.hubspot.com/products/crm/live-chat

## Step 2: Sign Up and Get Embed Code
1. Create an account with your chosen service
2. Go to the installation/embed code section
3. Copy the JavaScript embed code

## Step 3: Update Website Files
1. **Option A: Add to all pages manually**
   - Paste the embed code just before the closing `</body>` tag in each HTML file

2. **Option B: Update via JavaScript (recommended)**
   - Replace the placeholder in `js/chat-config.js` with the actual embed code
   - The `initializeChatWidget()` function should load the actual chat widget

## Step 4: Configure Chat Settings
Configure these settings in your chat service dashboard:
- **Business Hours**: Mon-Fri 9am-5pm, Sat 9am-1pm ET
- **Automated Greetings**: Use the messages from `chatConfig.messages`
- **Staff Assignment**: Set up routing for different types of inquiries
- **Offline Form**: Configure to capture messages when offline
- **Notifications**: Set up email/SMS alerts for new messages

## Step 5: Customize Appearance
Match the chat widget to your website design:
- Primary color: `#00CED1` (medical cyan)
- Position: Bottom right
- Mobile responsive

## Step 6: Test Thoroughly
Test the chat functionality:
1. During business hours vs. outside business hours
2. On desktop and mobile devices
3. Send test messages and receive responses
4. Test offline message capture
5. Verify staff notifications work

## Step 7: Train Staff
1. Create response protocols for common questions
2. Set expectations for response times
3. Train staff on using the chat dashboard
4. Establish escalation procedures for complex inquiries

## Integration Notes
- The chat widget should load on ALL pages
- Consider adding a chat option to the contact form page
- Monitor analytics to optimize chat performance
- Regularly review chat transcripts for quality assurance
EOF
echo "📄 Created chat-installation.md"

echo "✅ Live chat setup complete!"
echo ""
echo "Next steps:"
echo "1. Choose and sign up for a chat service (Tawk.to, Crisp, etc.)"
echo "2. Get the embed code and update js/chat-config.js"
echo "3. Configure business hours and automated responses"
echo "4. Test the chat functionality thoroughly"
echo "5. Train staff on using the chat system"
echo ""
echo "Run './final.sh' when feature is complete."
EOF
echo "📄 Created features/live-chat/startup.sh"

echo "✅ Live chat startup script created!"