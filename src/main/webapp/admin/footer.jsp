<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="bg-dark text-white text-center py-3 mt-auto">
    <p class="mb-0">&copy; 2026 Ebook App. Designed for Ebook Store Project.</p>
</footer>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Global Toast Notification Script -->
<script>
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    <% if (session.getAttribute("succMsg") != null) { %>
        Toast.fire({
            icon: 'success',
            title: '<%= session.getAttribute("succMsg") %>'
        });
        <% session.removeAttribute("succMsg"); %>
    <% } %>

    <% if (session.getAttribute("failedMsg") != null) { %>
        Toast.fire({
            icon: 'error',
            title: '<%= session.getAttribute("failedMsg") %>'
        });
        <% session.removeAttribute("failedMsg"); %>
    <% } %>

    <% if (session.getAttribute("warnMsg") != null) { %>
        Toast.fire({
            icon: 'warning',
            title: '<%= session.getAttribute("warnMsg") %>'
        });
        <% session.removeAttribute("warnMsg"); %>
    <% } %>
</script>
