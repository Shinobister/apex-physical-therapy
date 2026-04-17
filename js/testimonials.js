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
        {
            id: 2,
            name: "Sarah M.",
            condition: "Chronic Back Pain",
            rating: 5,
            text: "After years of back pain, I finally found relief with Dr. Bishnoi's manual therapy approach. Life-changing!",
            date: "2024-02-28",
            service: "manual-therapy"
        },
        {
            id: 3,
            name: "Michael T.",
            condition: "Sports Injury Recovery",
            rating: 5,
            text: "As a marathon runner, I needed targeted rehab to get back to training. The smart loading program worked perfectly.",
            date: "2024-03-10",
            service: "sports-medicine"
        },
        {
            id: 4,
            name: "Lisa R.",
            condition: "Shoulder Impingement",
            rating: 5,
            text: "The progressive loading approach helped me regain full range of motion without pain. Highly recommend!",
            date: "2024-01-22",
            service: "orthopedics"
        },
        {
            id: 5,
            name: "Robert K.",
            condition: "Post-Surgical Rehabilitation",
            rating: 5,
            text: "Professional, knowledgeable, and compassionate care throughout my recovery journey.",
            date: "2024-02-15",
            service: "post-surgical"
        },
        {
            id: 6,
            name: "Jennifer L.",
            condition: "Arthritis Management",
            rating: 5,
            text: "The exercises and techniques taught here have given me tools to manage my arthritis daily.",
            date: "2024-03-05",
            service: "orthopedics"
        }
    ];

    // Render testimonials on dedicated page
    const container = document.getElementById('testimonials-container');
    if (container) {
        renderTestimonials(testimonials);
    }

    // Initialize carousel on homepage
    const carouselTrack = document.getElementById('testimonial-carousel-track');
    const carouselDots = document.getElementById('testimonial-carousel-dots');
    if (carouselTrack && carouselDots) {
        initCarousel(testimonials);
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
        card.setAttribute('itemscope', '');
        card.setAttribute('itemtype', 'https://schema.org/Review');

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
                    <h3 class="font-semibold" itemprop="author" itemscope itemtype="https://schema.org/Person">
                        <span itemprop="name">${testimonial.name}</span>
                    </h3>
                    <p class="text-sm text-gray-600">${testimonial.condition}</p>
                </div>
            </div>
            <div class="text-yellow-500 mb-4" itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating">
                <meta itemprop="ratingValue" content="${testimonial.rating}">
                <meta itemprop="bestRating" content="5">
                ${stars}
            </div>
            <p class="mb-4 italic" itemprop="reviewBody">"${testimonial.text}"</p>
            <div class="flex justify-between items-center text-sm text-gray-500">
                <span>${testimonial.service}</span>
                <span itemprop="datePublished">${testimonial.date}</span>
            </div>
        `;

        return card;
    }

    function initCarousel(testimonialsArray) {
        let currentIndex = 0;
        let slidesToShow = getSlidesToShow();
        const totalTestimonials = testimonialsArray.length;

        // Create individual slides (one per testimonial)
        carouselTrack.innerHTML = '';
        testimonialsArray.forEach(testimonial => {
            const slide = document.createElement('div');
            slide.className = 'carousel-slide';
            const card = createTestimonialCard(testimonial);
            slide.appendChild(card);
            carouselTrack.appendChild(slide);
        });

        const totalSlides = totalTestimonials;
        let maxIndex = Math.max(0, totalSlides - slidesToShow);
        let totalDots = slidesToShow >= totalSlides ? 1 : Math.ceil(totalSlides / slidesToShow);

        // Create dots
        function createDots() {
            carouselDots.innerHTML = '';
            for (let i = 0; i < totalDots; i++) {
                const dot = document.createElement('button');
                dot.className = `carousel-dot ${i === 0 ? 'active' : ''}`;
                dot.setAttribute('aria-label', `Go to testimonial group ${i + 1}`);
                dot.addEventListener('click', () => goToSlide(i));
                carouselDots.appendChild(dot);
            }
        }
        createDots();

        // Set up button events
        const prevBtn = document.querySelector('.carousel-btn-prev');
        const nextBtn = document.querySelector('.carousel-btn-next');
        if (prevBtn) prevBtn.addEventListener('click', () => prevSlide());
        if (nextBtn) nextBtn.addEventListener('click', () => nextSlide());

        // Auto-play
        let autoplayInterval = setInterval(nextSlide, 5000);

        // Pause autoplay on hover
        carouselTrack.addEventListener('mouseenter', () => clearInterval(autoplayInterval));
        carouselTrack.addEventListener('mouseleave', () => {
            autoplayInterval = setInterval(nextSlide, 5000);
        });

        function getSlidesToShow() {
            if (window.innerWidth >= 1024) return 3;
            if (window.innerWidth >= 768) return 2;
            return 1;
        }

        // Calculate translation percentage accounting for gap
        function getTranslatePercent(index) {
            const container = carouselTrack.parentElement;
            if (!container) return index * (100 / slidesToShow);

            const containerWidth = container.offsetWidth;
            if (containerWidth === 0) return index * (100 / slidesToShow);

            // Get gap from computed style
            const trackStyle = window.getComputedStyle(carouselTrack);
            const gap = parseFloat(trackStyle.gap) || 0; // in pixels

            // Gap as percentage of container
            const gapPercent = (gap / containerWidth) * 100;

            // Each slide takes (100% - (slidesToShow-1)*gapPercent)/slidesToShow
            // Distance between slides = slideWidth + gap = (100% + gapPercent)/slidesToShow
            const slideStepPercent = (100 + gapPercent) / slidesToShow;
            return index * slideStepPercent;
        }

        function updateCarousel() {
            const translatePercent = getTranslatePercent(currentIndex);
            carouselTrack.style.transform = `translateX(-${translatePercent}%)`;

            // Update dots
            const activeDotIndex = Math.floor(currentIndex / slidesToShow);
            document.querySelectorAll('.carousel-dot').forEach((dot, index) => {
                dot.classList.toggle('active', index === activeDotIndex);
            });
        }

        function nextSlide() {
            slidesToShow = getSlidesToShow();
            maxIndex = Math.max(0, totalSlides - slidesToShow);
            if (currentIndex >= maxIndex) {
                currentIndex = 0; // Loop back to start
            } else {
                currentIndex++;
            }
            updateCarousel();
        }

        function prevSlide() {
            slidesToShow = getSlidesToShow();
            maxIndex = Math.max(0, totalSlides - slidesToShow);
            if (currentIndex <= 0) {
                currentIndex = maxIndex; // Loop to end
            } else {
                currentIndex--;
            }
            updateCarousel();
        }

        function goToSlide(dotIndex) {
            slidesToShow = getSlidesToShow();
            maxIndex = Math.max(0, totalSlides - slidesToShow);
            // dotIndex corresponds to group index
            currentIndex = Math.min(dotIndex * slidesToShow, maxIndex);
            updateCarousel();
        }

        // Update on window resize
        let resizeTimeout;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimeout);
            resizeTimeout = setTimeout(() => {
                const newSlidesToShow = getSlidesToShow();
                if (newSlidesToShow !== slidesToShow) {
                    slidesToShow = newSlidesToShow;
                    maxIndex = Math.max(0, totalSlides - slidesToShow);
                    totalDots = slidesToShow >= totalSlides ? 1 : Math.ceil(totalSlides / slidesToShow);

                    // Update current index if out of bounds
                    if (currentIndex > maxIndex) {
                        currentIndex = maxIndex;
                    }

                    // Recreate dots
                    createDots();
                    updateCarousel();
                } else {
                    // Even if slidesToShow unchanged, update translation for possible container width change
                    updateCarousel();
                }
            }, 250);
        });

        // Initial update
        updateCarousel();
    }
});