<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<%--
    GUARD: If users list was not set (i.e., page accessed directly instead of via servlet),
    redirect to the servlet so the DB query runs first.
--%>
<c:if test="${users == null}">
    <c:redirect url="/admin/users"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — User Management</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .content-body {
            padding: 0 20px 20px 20px;
        }
        .page-title {
            font-size: 1.25rem;
            color: #1e293b;
            font-weight: 600;
        }
        .ui-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .table th {
            font-size: 0.75rem;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 600;
            letter-spacing: 0.5px;
            background-color: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
        }
        .table td {
            font-size: 0.85rem;
            color: #334155;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }
        .role-badge {
            font-size: 0.7rem;
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 12px;
        }
        .role-admin { background-color: #e0e7ff; color: #3730a3; }
        .role-user  { background-color: #f1f5f9; color: #475569; }

        .btn-action {
            font-size: 0.75rem;
            padding: 4px 10px;
            border-radius: 6px;
        }
        .avatar-circle {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #64748b;
            font-size: 0.8rem;
            flex-shrink: 0;
        }
        .empty-state {
            padding: 60px 20px;
            text-align: center;
            color: #94a3b8;
        }
        .empty-state i {
            font-size: 2.5rem;
            margin-bottom: 12px;
            display: block;
        }
    </style>
</head>
<body>

    <%-- Security Check --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%-- Set active page for navbar highlight --%>
    <c:set var="activePage" value="users" scope="request"/>

<%@include file="navbar.jsp" %>

<main class="admin-main">
    <!-- Breadcrumbs -->
    <div class="breadcrumb-bar bg-white px-4 py-2 border-bottom mb-4 text-muted" style="font-size: 11px;">
        Home &gt; Admin Console &gt; User Management
    </div>

    <div class="content-body">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h2 class="page-title mb-0">System Users</h2>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-danger btn-sm px-3 shadow-sm d-none" id="bulkDeleteBtn">
                    <i class="fas fa-trash-alt me-1"></i> Delete Selected
                </button>
            </div>
        </div>

        <div class="ui-card">
            <div class="table-responsive p-0">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4" style="width: 40px;">
                                <div class="form-check">
                                    <input class="form-check-input select-all-chk" type="checkbox">
                                </div>
                            </th>
                            <th>User</th>
                            <th>Contact Info</th>
                            <th>Location</th>
                            <th>Role</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty users}">
                                <tr>
                                    <td colspan="6">
                                        <div class="empty-state">
                                            <i class="fas fa-users-slash"></i>
                                            <div class="fw-semibold mb-1">No users found</div>
                                            <div class="small">Registered users will appear here.</div>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="form-check">
                                                <input class="form-check-input user-chk" type="checkbox" value="${u.id}">
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="avatar-circle">
                                                    ${fn:toUpperCase(fn:substring(u.name, 0, 1))}
                                                </div>
                                                <div>
                                                    <div class="fw-semibold" style="font-size:0.85rem;">${u.name}</div>
                                                    <div class="text-muted" style="font-size:0.75rem;">#UID-${u.id}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="font-size:0.82rem;">${u.email}</div>
                                            <div class="text-muted" style="font-size:0.75rem;">
                                                <c:choose>
                                                    <c:when test="${not empty u.phone}">${u.phone}</c:when>
                                                    <c:otherwise>—</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="font-size:0.82rem;">
                                                <c:choose>
                                                    <c:when test="${not empty u.city}">
                                                        ${u.city}<c:if test="${not empty u.state}">, ${u.state}</c:if>
                                                    </c:when>
                                                    <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.email == 'admin@gmail.com'}">
                                                    <span class="role-badge role-admin"><i class="fas fa-shield-alt me-1"></i>Admin</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="role-badge role-user"><i class="fas fa-user me-1"></i>User</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <c:if test="${u.email != 'admin@gmail.com'}">
                                                <button type="button"
                                                    class="btn btn-outline-danger btn-action btn-delete"
                                                    data-id="${u.id}"
                                                    data-name="${u.name}">
                                                    <i class="fas fa-trash-alt me-1"></i>Delete
                                                </button>
                                            </c:if>
                                            <c:if test="${u.email == 'admin@gmail.com'}">
                                                <span class="text-muted small">Protected</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <div class="d-flex align-items-center justify-content-between p-3 border-top bg-light text-muted" style="font-size: 0.8rem;">
                <div>Showing <strong>${totalUsers}</strong> user<c:if test="${totalUsers != 1}">s</c:if></div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
            <div class="modal-content">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fs-6 fw-bold text-danger" id="deleteModalLabel">
                        <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body pt-2">
                    <p class="mb-0 text-muted" style="font-size:0.875rem;">
                        Are you sure you want to delete user <strong id="deleteUserName"></strong>?
                        This action cannot be undone.
                    </p>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/users" class="d-inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" id="deleteUserId">
                        <button type="submit" class="btn btn-sm btn-danger">
                            <i class="fas fa-trash-alt me-1"></i>Delete User
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function () {

        // --- Select All Checkbox ---
        const selectAll     = document.querySelector('.select-all-chk');
        const userChecks    = document.querySelectorAll('.user-chk');
        const bulkDeleteBtn = document.getElementById('bulkDeleteBtn');

        function updateBulkActionState() {
            const anyChecked = Array.from(userChecks).some(chk => chk.checked);
            bulkDeleteBtn.classList.toggle('d-none', !anyChecked);
        }

        if (selectAll) {
            selectAll.addEventListener('change', function (e) {
                userChecks.forEach(chk => { chk.checked = e.target.checked; });
                updateBulkActionState();
            });
        }
        userChecks.forEach(chk => chk.addEventListener('change', updateBulkActionState));

        // --- Single Delete Confirm Modal ---
        const deleteModal    = new bootstrap.Modal(document.getElementById('deleteModal'));
        const deleteUserName = document.getElementById('deleteUserName');
        const deleteUserId   = document.getElementById('deleteUserId');

        document.querySelectorAll('.btn-delete').forEach(btn => {
            btn.addEventListener('click', function () {
                deleteUserName.textContent = this.dataset.name;
                deleteUserId.value         = this.dataset.id;
                deleteModal.show();
            });
        });
    });
</script>

</body>
</html>
