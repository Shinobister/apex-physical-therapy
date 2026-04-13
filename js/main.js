// Main JavaScript for Apex Physical Therapy Website

document.addEventListener('DOMContentLoaded', function() {
    // Mobile Menu Toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const navMenu = document.getElementById('navMenu');

    if (mobileMenuBtn && navMenu) {
        mobileMenuBtn.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            mobileMenuBtn.classList.toggle('active');

            // Animate hamburger to X
            const spans = mobileMenuBtn.querySelectorAll('span');
            if (navMenu.classList.contains('active')) {
                spans[0].style.transform = 'rotate(45deg) translate(5px, 5px)';
                spans[1].style.opacity = '0';
                spans[2].style.transform = 'rotate(-45deg) translate(7px, -6px)';
            } else {
                spans[0].style.transform = 'none';
                spans[1].style.opacity = '1';
                spans[2].style.transform = 'none';
            }
        });
    }

    // Smooth Scrolling for Navigation Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();

            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                // Close mobile menu if open
                if (navMenu && navMenu.classList.contains('active')) {
                    navMenu.classList.remove('active');
                    mobileMenuBtn.classList.remove('active');
                    const spans = mobileMenuBtn.querySelectorAll('span');
                    spans[0].style.transform = 'none';
                    spans[1].style.opacity = '1';
                    spans[2].style.transform = 'none';
                }

                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Navbar Scroll Effect
    const navbar = document.getElementById('navbar');
    let lastScrollTop = 0;

    window.addEventListener('scroll', function() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        // Add scrolled class when not at top
        if (scrollTop > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }

        // Hide/show navbar on scroll direction
        if (scrollTop > lastScrollTop && scrollTop > 100) {
            // Scrolling down
            navbar.style.transform = 'translateY(-100%)';
        } else {
            // Scrolling up
            navbar.style.transform = 'translateY(0)';
        }

        lastScrollTop = scrollTop;

        // Update scroll progress indicator
        updateScrollProgress();
    });

    // Scroll Progress Indicator
    function updateScrollProgress() {
        const scrollProgress = document.querySelector('.scroll-progress');
        if (!scrollProgress) return;

        const windowHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrolled = (window.scrollY / windowHeight) * 100;
        scrollProgress.style.width = scrolled + '%';
    }

    // Active Navigation Link Highlighting
    function highlightActiveNavLink() {
        const sections = document.querySelectorAll('section[id]');
        const navLinks = document.querySelectorAll('.nav-link');

        let currentSectionId = '';

        sections.forEach(section => {
            const sectionTop = section.offsetTop - 100;
            const sectionHeight = section.clientHeight;

            if (window.scrollY >= sectionTop && window.scrollY < sectionTop + sectionHeight) {
                currentSectionId = '#' + section.id;
            }
        });

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === currentSectionId) {
                link.classList.add('active');
            }
        });
    }

    window.addEventListener('scroll', highlightActiveNavLink);

    // Accordion Functionality
    document.querySelectorAll('.accordion-header').forEach(header => {
        header.addEventListener('click', function() {
            const accordionItem = this.parentElement;
            const accordionContent = this.nextElementSibling;

            // Close other accordion items
            document.querySelectorAll('.accordion-item').forEach(item => {
                if (item !== accordionItem) {
                    item.querySelector('.accordion-header').classList.remove('active');
                    item.querySelector('.accordion-content').classList.remove('active');
                }
            });

            // Toggle current item
            this.classList.toggle('active');
            accordionContent.classList.toggle('active');
        });
    });

    // Contact Form Validation
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();

            let isValid = true;

            // First Name validation
            const firstNameInput = document.getElementById('firstName');
            if (!firstNameInput.value.trim()) {
                showError(firstNameInput, 'Please enter your first name');
                isValid = false;
            } else {
                clearError(firstNameInput);
            }

            // Last Name validation
            const lastNameInput = document.getElementById('lastName');
            if (!lastNameInput.value.trim()) {
                showError(lastNameInput, 'Please enter your last name');
                isValid = false;
            } else {
                clearError(lastNameInput);
            }

            // Phone validation
            const phoneInput = document.getElementById('phone');
            const phoneRegex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
            if (!phoneRegex.test(phoneInput.value.trim())) {
                showError(phoneInput, 'Please enter a valid phone number');
                isValid = false;
            } else {
                clearError(phoneInput);
            }

            // Email validation
            const emailInput = document.getElementById('email');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(emailInput.value.trim())) {
                showError(emailInput, 'Please enter a valid email address');
                isValid = false;
            } else {
                clearError(emailInput);
            }

            // Message validation
            const messageInput = document.getElementById('message');
            if (!messageInput.value.trim()) {
                showError(messageInput, 'Please enter your message');
                isValid = false;
            } else {
                clearError(messageInput);
            }

            // Consent validation
            const consentInput = document.getElementById('consent');
            if (!consentInput.checked) {
                showError(consentInput, 'Please consent to receive communications');
                isValid = false;
            } else {
                clearError(consentInput);
            }

            if (isValid) {
                // Show sending state
                const submitBtn = contactForm.querySelector('button[type="submit"]');
                const originalText = submitBtn.textContent;
                submitBtn.textContent = 'Sending...';
                submitBtn.disabled = true;

                // Submit the form to Netlify
                // This will navigate to thank-you.html via form action
                contactForm.submit();
            }
        });

        // Real-time validation
        const inputs = contactForm.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateField(this);
            });

            input.addEventListener('input', function() {
                clearError(this);
            });
        });
    }

    function validateField(field) {
        const value = field.value.trim();
        const id = field.id;

        // Clear any existing error
        clearError(field);

        // Required field validation
        if (field.hasAttribute('required') && !value) {
            let message = 'This field is required';
            if (id === 'firstName') message = 'Please enter your first name';
            else if (id === 'lastName') message = 'Please enter your last name';
            else if (id === 'phone') message = 'Please enter a phone number';
            else if (id === 'email') message = 'Please enter an email address';
            else if (id === 'message') message = 'Please enter your message';
            else if (id === 'consent') message = 'Please consent to receive communications';

            showError(field, message);
            return false;
        }

        // Phone validation
        if (id === 'phone' && value) {
            const phoneRegex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
            if (!phoneRegex.test(value)) {
                showError(field, 'Please enter a valid phone number');
                return false;
            }
        }

        // Email validation
        if (id === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                showError(field, 'Please enter a valid email address');
                return false;
            }
        }

        return true;
    }

    function showError(field, message) {
        field.classList.add('error');

        let errorElement = field.parentElement.querySelector('.form-error');
        if (!errorElement) {
            errorElement = document.createElement('div');
            errorElement.className = 'form-error';
            field.parentElement.appendChild(errorElement);
        }

        errorElement.textContent = message;
        errorElement.classList.add('show');
    }

    function clearError(field) {
        field.classList.remove('error');

        const errorElement = field.parentElement.querySelector('.form-error');
        if (errorElement) {
            errorElement.classList.remove('show');
        }
    }

    // Lazy Load Images
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    observer.unobserve(img);
                }
            });
        });

        document.querySelectorAll('img[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }

    // Service Card Hover Effects
    document.querySelectorAll('.service-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px)';
            this.style.boxShadow = '0 20px 40px rgba(0, 206, 209, 0.15)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '';
        });
    });

    // Button Hover Effects
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('mouseenter', function() {
            if (!this.classList.contains('btn-pulse')) {
                this.style.transform = 'translateY(-2px)';
            }
        });

        button.addEventListener('mouseleave', function() {
            if (!this.classList.contains('btn-pulse')) {
                this.style.transform = 'translateY(0)';
            }
        });
    });

    // Parallax Effect for Hero Section
    const heroBg = document.querySelector('.hero-bg');
    if (heroBg) {
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const rate = scrolled * -0.5;
            heroBg.style.transform = `translate3d(0, ${rate}px, 0)`;
        });
    }

    // Initialize on load
    highlightActiveNavLink();
    updateScrollProgress();

    // Add loading animation to service icons on view
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const serviceObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animated');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.service-card').forEach(card => {
        serviceObserver.observe(card);
    });

    // Add current year to footer
    const currentYear = new Date().getFullYear();
    const yearElements = document.querySelectorAll('.current-year');
    yearElements.forEach(element => {
        element.textContent = currentYear;
    });

    // Print button functionality
    const printBtn = document.querySelector('.btn-print');
    if (printBtn) {
        printBtn.addEventListener('click', function() {
            window.print();
        });
    }

    // Accessibility: Add focus management for modals
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            // Close any open modals or menus
            if (navMenu && navMenu.classList.contains('active')) {
                navMenu.classList.remove('active');
                mobileMenuBtn.classList.remove('active');
                const spans = mobileMenuBtn.querySelectorAll('span');
                spans[0].style.transform = 'none';
                spans[1].style.opacity = '1';
                spans[2].style.transform = 'none';
            }
        }
    });

    // Initialize tooltips
    document.querySelectorAll('[data-tooltip]').forEach(element => {
        element.addEventListener('mouseenter', function() {
            const tooltipText = this.getAttribute('data-tooltip');
            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
            tooltip.textContent = tooltipText;
            document.body.appendChild(tooltip);

            const rect = this.getBoundingClientRect();
            tooltip.style.left = rect.left + rect.width / 2 - tooltip.offsetWidth / 2 + 'px';
            tooltip.style.top = rect.top - tooltip.offsetHeight - 5 + 'px';

            this.tooltipElement = tooltip;
        });

        element.addEventListener('mouseleave', function() {
            if (this.tooltipElement) {
                this.tooltipElement.remove();
                this.tooltipElement = null;
            }
        });
    });

    // Add copy-to-clipboard for phone number
    const phoneElements = document.querySelectorAll('.copy-phone');
    phoneElements.forEach(element => {
        element.addEventListener('click', function() {
            const phoneNumber = this.textContent.trim();
            navigator.clipboard.writeText(phoneNumber).then(() => {
                const originalText = this.textContent;
                this.textContent = 'Copied!';
                setTimeout(() => {
                    this.textContent = originalText;
                }, 2000);
            });
        });
    });

    console.log('Apex Physical Therapy website initialized successfully.');
});

// Utility Functions
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}