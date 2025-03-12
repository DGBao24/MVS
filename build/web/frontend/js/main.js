// Seat Selection
document.addEventListener('DOMContentLoaded', function() {
    const seatMap = document.querySelector('.seat-map');
    if (seatMap) {
        seatMap.addEventListener('click', function(e) {
            if (e.target.classList.contains('seat') && !e.target.classList.contains('occupied')) {
                e.target.classList.toggle('selected');
                updateBookingSummary();
            }
        });
    }
});

// Update Booking Summary
function updateBookingSummary() {
    const selectedSeats = document.querySelectorAll('.seat.selected');
    const ticketPrice = 15; // Price per ticket
    const bookingFee = 1; // Fee per ticket

    // Update selected seats text
    const seatsText = Array.from(selectedSeats).map(seat => {
        const row = seat.parentElement.querySelector('span').textContent;
        const seatNumber = Array.from(seat.parentElement.children).indexOf(seat);
        return `${row}${seatNumber}`;
    }).join(', ');

    // Update prices
    const ticketsTotal = selectedSeats.length * ticketPrice;
    const feesTotal = selectedSeats.length * bookingFee;
    const total = ticketsTotal + feesTotal;

    // Update DOM elements
    document.querySelector('.booking-summary .selected-seats').textContent = 
        `${seatsText} (${selectedSeats.length} tickets)`;
    document.querySelector('.booking-summary .tickets-price').textContent = 
        `$${ticketsTotal.toFixed(2)}`;
    document.querySelector('.booking-summary .booking-fee').textContent = 
        `$${feesTotal.toFixed(2)}`;
    document.querySelector('.booking-summary .total-price').textContent = 
        `$${total.toFixed(2)}`;
}

// Movie Trailer Modal
const trailerModal = document.getElementById('trailerModal');
if (trailerModal) {
    trailerModal.addEventListener('hidden.bs.modal', function () {
        const iframe = trailerModal.querySelector('iframe');
        const videoSrc = iframe.src;
        iframe.src = ''; // Stop video playback
        iframe.src = videoSrc;
    });
}

// Movie Filter
const genreFilter = document.querySelector('select[name="genre"]');
if (genreFilter) {
    genreFilter.addEventListener('change', function() {
        // Add filter logic here
        console.log('Filter by genre:', this.value);
    });
}

// Carousel Auto-play
const heroCarousel = document.getElementById('heroCarousel');
if (heroCarousel) {
    const carousel = new bootstrap.Carousel(heroCarousel, {
        interval: 5000,
        ride: true
    });
}

// Smooth Scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// Form Validation
const forms = document.querySelectorAll('.needs-validation');
forms.forEach(form => {
    form.addEventListener('submit', function(event) {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });
});

// Toast Notifications
function showToast(message, type = 'success') {
    const toastContainer = document.createElement('div');
    toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
    
    const toastHTML = `
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header bg-${type} text-white">
                <strong class="me-auto">Notification</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body bg-dark text-light">
                ${message}
            </div>
        </div>
    `;
    
    toastContainer.innerHTML = toastHTML;
    document.body.appendChild(toastContainer);
    
    const toast = new bootstrap.Toast(toastContainer.querySelector('.toast'));
    toast.show();
    
    // Remove toast container after hiding
    toastContainer.addEventListener('hidden.bs.toast', function() {
        document.body.removeChild(toastContainer);
    });
}

// Example usage of toast:
// showToast('Seats selected successfully!', 'success');
// showToast('Please select at least one seat', 'danger');

// Login/Logout Functionality
document.addEventListener('DOMContentLoaded', function() {
    const loginBtn = document.getElementById('loginBtn');
    const accountDropdown = document.getElementById('accountDropdown');
    const logoutBtn = document.getElementById('logoutBtn');

    // Check if user is logged in (you can use localStorage or session storage)
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    if (isLoggedIn) {
        loginBtn.classList.add('d-none');
        accountDropdown.classList.remove('d-none');
    }

    // Login button click
    loginBtn.addEventListener('click', function() {
        // Here you would typically handle login authentication
        // For demo purposes, we'll just simulate a login
        localStorage.setItem('isLoggedIn', 'true');
        loginBtn.classList.add('d-none');
        accountDropdown.classList.remove('d-none');
        showToast('Logged in successfully!', 'success');
    });

    // Logout button click
    logoutBtn.addEventListener('click', function(e) {
        e.preventDefault();
        localStorage.removeItem('isLoggedIn');
        accountDropdown.classList.add('d-none');
        loginBtn.classList.remove('d-none');
        showToast('Logged out successfully!', 'success');
    });
});

// Combo and Payment Functionality
const comboPrices = {
    combo1: 15.99,
    combo2: 18.99
};

function updateComboQuantity(comboId, change) {
    const input = document.getElementById(comboId);
    const currentValue = parseInt(input.value);
    const newValue = Math.max(0, Math.min(5, currentValue + change));
    input.value = newValue;
    updateTotalAmount();
}

function updateTotalAmount() {
    const combo1Total = document.getElementById('combo1').value * comboPrices.combo1;
    const combo2Total = document.getElementById('combo2').value * comboPrices.combo2;
    const comboTotal = combo1Total + combo2Total;
    
    // Update combo total display
    document.getElementById('comboTotal').textContent = `$${comboTotal.toFixed(2)}`;
    
    // Calculate total (including tickets and booking fee)
    const ticketsTotal = 30.00; // This should be dynamic based on selected seats
    const bookingFee = 2.00;
    const total = ticketsTotal + comboTotal + bookingFee;
    
    // Update total amount display
    document.getElementById('totalAmount').textContent = `$${total.toFixed(2)}`;
}

function proceedToPayment() {
    // Validate if user is logged in
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    if (!isLoggedIn) {
        showToast('Please login to continue with payment', 'danger');
        return;
    }

    // Here you would typically handle the payment processing
    showToast('Processing payment...', 'info');
    
    // Simulate payment processing
    setTimeout(() => {
        showToast('Payment successful! Booking confirmed.', 'success');
        // Here you would typically redirect to a confirmation page
    }, 2000);
}

// My Bookings Page Functions
function showQRCode(bookingId) {
    const qrModal = new bootstrap.Modal(document.getElementById('qrCodeModal'));
    qrModal.show();
}

function cancelBooking(bookingId) {
    if (confirm('Are you sure you want to cancel this booking?')) {
        // Here we would make an API call to cancel the booking
        showToast('Booking cancelled successfully');
    }
}

function rateMovie(bookingId) {
    const rateModal = new bootstrap.Modal(document.getElementById('rateMovieModal'));
    rateModal.show();
}

// Rating Stars Functionality
document.querySelectorAll('.rating-stars i').forEach(star => {
    star.addEventListener('click', (e) => {
        const rating = e.target.dataset.rating;
        const stars = e.target.parentElement.children;
        
        // Reset all stars
        Array.from(stars).forEach(s => {
            s.classList.remove('bi-star-fill');
            s.classList.add('bi-star');
        });
        
        // Fill stars up to selected rating
        for (let i = 0; i < rating; i++) {
            stars[i].classList.remove('bi-star');
            stars[i].classList.add('bi-star-fill');
        }
    });
});
