<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${news != null ? 'Sửa tin tức' : 'Thêm tin tức'} - XYZ Admin Premium</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
                
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
/* ===========================
   CUSTOM VARIABLES (Đồng bộ với Dashboard)
=========================== */
:root {
    --primary-navy: #0f172a; /* Navy đậm sang trọng cho Sidebar/Header chính */
    --secondary-navy: #1e293b; /* Navy nhạt hơn cho Card Header */
    --accent-blue: #3b82f6; /* Xanh điểm nhấn */
    --light-bg: #f1f5f9; /* Nền xám xanh nhẹ */
    --text-dark: #334155;
    --white: #ffffff;
    --shadow-soft: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

/* ===========================
   RESET & TYPOGRAPHY
=========================== */
* {
    font-family: 'Be Vietnam Pro', sans-serif;
    transition: all 0.3s ease;
}

body {
    background-color: var(--light-bg);
    color: var(--text-dark);
    overflow-x: hidden;
}

/* ===========================
   SIDEBAR (Đồng bộ hoàn toàn)
=========================== */
.sidebar {
    height: 100vh;
    background: var(--primary-navy); 
    box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1); 
    z-index: 1000;
}

.sidebar h5 {
    font-weight: 700;
    letter-spacing: 0.5px;
    color: var(--white);
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 20px;
    text-align: center;
}

.sidebar .nav-link {
    color: #cbd5e1;
    padding: 14px 20px;
    margin-bottom: 8px;
    border-radius: 12px;
    font-size: 0.95rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 12px;
}

.sidebar .nav-link i {
    width: 24px;
    text-align: center;
    font-size: 1.1rem;
}

/* Hiệu ứng Hover */
.sidebar .nav-link:hover {
    background: rgba(255, 255, 255, 0.1);
    color: var(--white);
    transform: translateX(5px);
}

/* Hiệu ứng Active */
.sidebar .nav-link.active {
    background: linear-gradient(90deg, var(--accent-blue), #2563eb);
    color: var(--white) !important;
    font-weight: 600;
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
    transform: none;
}

.sidebar hr {
    background-color: rgba(255, 255, 255, 0.2);
    opacity: 1;
}

/* ===========================
   MAIN CONTENT & NAVBAR
=========================== */
.main-content {
    background-color: var(--light-bg);
    padding-left: 0;
}

.navbar-admin {
    background: var(--white);
    padding: 1rem 2rem; 
    box-shadow: var(--shadow-soft);
    margin-bottom: 2rem;
    border-radius: 0 0 20px 20px; 
    border-bottom: none; /* Xóa viền xanh */
    z-index: 900;
}

.navbar-admin h4 {
    color: var(--primary-navy);
    font-weight: 700;
    font-size: 1.5rem;
}

/* Button Quay Lại */
.navbar-admin .btn-outline-secondary {
    color: var(--primary-navy);
    border-color: #e2e8f0;
    font-weight: 600;
    border-radius: 10px;
}
.navbar-admin .btn-outline-secondary:hover {
    background-color: var(--primary-navy);
    color: var(--white);
}

/* ===========================
   CARD & FORM (Đã chỉnh Card Header)
=========================== */
.card {
    border: none;
    border-radius: 20px;
    background: var(--white);
    box-shadow: var(--shadow-soft);
    margin-bottom: 2rem;
    overflow: hidden;
}

.card-header {
    background: var(--secondary-navy); 
    color: var(--white);
    font-weight: 600;
    font-size: 16px;
    padding: 1.2rem 1.5rem;
    border-bottom: none;
    border-radius: 20px 20px 0 0 !important;
}

.card-header h5 i {
    color: var(--white);
}

/* Form Input */
.form-control, .form-select {
    border-radius: 10px !important;
    border: 1px solid #cfd7e3;
    padding: 10px 14px;
    background-color: #f8fafc;
}

.form-control:focus, .form-select:focus {
    border-color: var(--accent-blue);
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
    background-color: var(--white);
}

/* Buttons */
.btn {
    border-radius: 10px !important;
    font-weight: 600;
    padding: 10px 18px;
    transition: all 0.3s ease;
}

.btn-primary {
    background-color: var(--accent-blue) !important;
    border-color: var(--accent-blue) !important;
}

.btn-primary:hover {
    background-color: #2563eb !important;
    border-color: #2563eb !important;
    box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
}

/* Button secondary (Hủy) */
.btn-secondary {
    background-color: #64748b !important;
    border-color: #64748b !important;
}

/* ===========================
   UPLOAD AREA (Đã chỉnh style)
=========================== */
.upload-area {
    border: 2px dashed #94a3b8 !important; /* Xám nhẹ */
    background-color: #f8fafc !important; /* Gần với light-bg */
    padding: 20px;
    text-align: center;
    cursor: pointer;
    border-radius: 12px;
}
.upload-area:hover,
.upload-area.dragover {
    border-color: var(--accent-blue) !important;
    background-color: #e0ecff !important;
}
.upload-area i {
    color: #94a3b8;
}

/* Uploaded image preview */
.news-image-preview {
    max-width: 100%; /* Đảm bảo hình ảnh không tràn khung */
    height: auto;
    max-height: 200px;
    border-radius: 12px;
    box-shadow: var(--shadow-soft);
    object-fit: cover;
}

/* Progress bar */
.upload-progress .progress-bar {
    background-color: var(--accent-blue) !important;
}
                </style>
            </head>

            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-3 col-lg-2 px-0 sidebar position-fixed">
                            <div class="p-3">
                                <h5 class="text-white mb-3 text-center">
                                    <i class="fas fa-layer-group me-2"></i> XYZ ADMIN
                                </h5>

                                <nav class="nav flex-column mt-4">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                        <i class="fas fa-chart-pie"></i> Dashboard
                                    </a>
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/news">
                                        <i class="fas fa-file-alt"></i> Quản lý tin tức
                                    </a>
                                    <c:if test="${sessionScope.currentUser.admin}">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                            <i class="fas fa-folder-open"></i> Quản lý chuyên mục
                                        </a>
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                            <i class="fas fa-users-cog"></i> Quản lý người dùng
                                        </a>
                                                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-comments"></i> Quản lý bình luận
                            </a>
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/newsletters">
                                            <i class="fas fa-envelope-open-text"></i> Newsletter
                                        </a>
                                    </c:if>
                                    <hr class="text-white-50">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                                        <i class="fas fa-external-link-alt"></i> Xem trang chủ
                                    </a>
                                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                    </a>
                                </nav>
                            </div>
                        </div>

                        <div class="col-md-9 col-lg-10 ms-auto main-content">
                            <nav class="navbar navbar-expand-lg navbar-admin sticky-top">
                                <div class="container-fluid">
                                    <h4 class="mb-0">${news != null ? 'Sửa tin tức' : 'Thêm tin tức mới'}</h4>
                                    <div class="navbar-nav ms-auto">
                                        <a href="${pageContext.request.contextPath}/admin/news"
                                            class="btn btn-outline-secondary">
                                            <i class="fas fa-arrow-left"></i> Quay lại
                                        </a>
                                    </div>
                                </div>
                            </nav>

                            <c:if test="${sessionScope.successMessage != null}">
                                <div class="container-fluid mt-3">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </div>
                                <c:remove var="successMessage" scope="session" />
                            </c:if>

                            <c:if test="${sessionScope.errorMessage != null}">
                                <div class="container-fluid mt-3">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </div>
                                <c:remove var="errorMessage" scope="session" />
                            </c:if>

                            <div class="container-fluid p-4">
                                <div class="row">
                                    <div class="col-lg-8">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-edit"></i> Thông tin tin tức
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <form id="newsForm"
                                                    action="${pageContext.request.contextPath}/admin/news/save"
                                                    method="post">
                                                    <c:if test="${news != null}">
                                                        <input type="hidden" name="id" value="${news.id}">
                                                    </c:if>

                                                    <div class="mb-3">
                                                        <label for="title" class="form-label">
                                                            <i class="fas fa-heading"></i> Tiêu đề <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <input type="text" class="form-control" id="title" name="title"
                                                            value="${news.title}" required maxlength="500"
                                                            placeholder="Nhập tiêu đề tin tức">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="categoryId" class="form-label">
                                                            <i class="fas fa-tags"></i> Chuyên mục <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <select class="form-select" id="categoryId" name="categoryId"
                                                            required>
                                                            <option value="">-- Chọn chuyên mục --</option>
                                                            <c:forEach var="category" items="${categories}">
                                                                <option value="${category.id}" ${news !=null &&
                                                                    news.categoryId==category.id ? 'selected' : '' }>
                                                                    ${category.name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="content" class="form-label">
                                                            <i class="fas fa-align-left"></i> Nội dung <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <textarea class="form-control" id="content" name="content"
                                                            rows="10" required
                                                            placeholder="Nhập nội dung tin tức">${news.content}</textarea>
                                                    </div>

                                                    <div class="mb-3">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="home"
                                                                name="home" ${news !=null && news.home ? 'checked' : ''
                                                                }>
                                                            <label class="form-check-label" for="home">
                                                                <i class="fas fa-star"></i> Hiển thị trên trang chủ
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" id="image" name="image" value="${news.image}">

                                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                        <a href="${pageContext.request.contextPath}/admin/news"
                                                            class="btn btn-secondary me-md-2">
                                                            <i class="fas fa-times"></i> Hủy
                                                        </a>
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-save"></i> ${news != null ? 'Cập nhật' :
                                                            'Thêm mới'}
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-image"></i> Hình ảnh
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <c:if test="${news != null && not empty news.image}">
                                                    <div class="mb-3">
                                                        <label class="form-label">Hình ảnh hiện tại:</label>
                                                        <div class="text-center">
                                                            <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                                class="news-image-preview" alt="${news.title}">
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <div class="upload-area" id="uploadArea">
                                                    <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                                    <h6>Kéo thả ảnh vào đây hoặc click để chọn</h6>
                                                    <p class="text-muted mb-0">Hỗ trợ: JPG, PNG, GIF (tối đa 10MB)</p>
                                                    <input type="file" id="imageInput" accept="image/*"
                                                        style="display: none;">
                                                </div>

                                                <div class="upload-progress mt-3" id="uploadProgress" style="display: none;">
                                                    <div class="progress">
                                                        <div class="progress-bar" role="progressbar" style="width: 0%">
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">Đang upload...</small>
                                                </div>

                                                <div class="mt-3" id="imagePreview" 

                                                <div class="mt-3" id="imagePreview" ${news != null && not empty news.image ? 'style="display: block;"' : 'style="display: none;"'}> 
                                                <label class="form-label">Hình ảnh mới:</label>
                                                    <div class="text-center">
                                                        <img id="previewImg" class="news-image-preview" alt="Preview">
                                                    </div>
                                                    <button type="button" class="btn btn-sm btn-outline-danger mt-2"
                                                        onclick="removeImage()">
                                                        <i class="fas fa-trash"></i> Xóa ảnh
                                                    </button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    const uploadArea = document.getElementById('uploadArea');
                    const imageInput = document.getElementById('imageInput');
                    const uploadProgress = document.getElementById('uploadProgress');
                    const imagePreview = document.getElementById('imagePreview');
                    const previewImg = document.getElementById('previewImg');
                    const imageHidden = document.getElementById('image');

                    // Check if there is an existing image to adjust visibility
                    window.onload = function() {
                        if (imageHidden.value && imageHidden.value.trim() !== '') {
                            uploadArea.style.display = 'none';
                        } else {
                            uploadArea.style.display = 'block';
                        }
                    };

                    // Click to select file
                    uploadArea.addEventListener('click', () => {
                        imageInput.click();
                    });

                    // File input change
                    imageInput.addEventListener('change', (e) => {
                        const file = e.target.files[0];
                        if (file) {
                            uploadFile(file);
                        }
                    });

                    // Drag and drop
                    uploadArea.addEventListener('dragover', (e) => {
                        e.preventDefault();
                        uploadArea.classList.add('dragover');
                    });

                    uploadArea.addEventListener('dragleave', () => {
                        uploadArea.classList.remove('dragover');
                    });

                    uploadArea.addEventListener('drop', (e) => {
                        e.preventDefault();
                        uploadArea.classList.remove('dragover');

                        const files = e.dataTransfer.files;
                        if (files.length > 0) {
                            const file = files[0];
                            if (file.type.startsWith('image/')) {
                                uploadFile(file);
                            } else {
                                alert('Vui lòng chọn file ảnh!');
                            }
                        }
                    });

                    // Upload file function
                    function uploadFile(file) {
                        // Validate file size (10MB)
                        if (file.size > 10 * 1024 * 1024) {
                            alert('File quá lớn! Vui lòng chọn file nhỏ hơn 10MB.');
                            return;
                        }

                        // Validate file type
                        if (!file.type.startsWith('image/')) {
                            alert('Vui lòng chọn file ảnh!');
                            return;
                        }

                        const formData = new FormData();
                        formData.append('image', file);

                        // Show progress
                        uploadProgress.style.display = 'block';
                        const progressBar = uploadProgress.querySelector('.progress-bar');
                        progressBar.style.width = '0%'; // Reset progress bar

                        // Upload file
                        fetch('${pageContext.request.contextPath}/admin/upload', {
                            method: 'POST',
                            body: formData
                        })
                            .then(response => response.json())
                            .then(data => {
                                uploadProgress.style.display = 'none';

                                if (data.filename) {
                                    // Update image input
                                    imageHidden.value = data.filename;

                                    // Show preview
                                    previewImg.src = '${pageContext.request.contextPath}/upload/' + data.filename;
                                    imagePreview.style.display = 'block';

                                    // Hide upload area
                                    uploadArea.style.display = 'none';
                                    
                                    // Hide current image (if editing)
                                    const currentImageDiv = document.querySelector('.card-body > .mb-3');
                                    if (currentImageDiv) {
                                        currentImageDiv.style.display = 'none';
                                    }
                                    
                                } else {
                                    alert('Lỗi upload: ' + (data.error || 'Unknown error'));
                                }
                            })
                            .catch(error => {
                                uploadProgress.style.display = 'none';
                                console.error('Error:', error);
                                alert('Có lỗi xảy ra khi upload file!');
                            });
                    }

                    // Remove image function
                    function removeImage() {
                        imageHidden.value = '';
                        imagePreview.style.display = 'none';
                        uploadArea.style.display = 'block';
                        imageInput.value = '';
                        
                        // Show current image (if editing and removing the NEW image)
                        const currentImageDiv = document.querySelector('.card-body > .mb-3');
                        if (currentImageDiv) {
                            currentImageDiv.style.display = 'block';
                        }
                    }

                    // Form validation
                    document.getElementById('newsForm').addEventListener('submit', function (e) {
                        const title = document.getElementById('title').value.trim();
                        const content = document.getElementById('content').value.trim();
                        const categoryId = document.getElementById('categoryId').value;
                        const imageValue = document.getElementById('image').value;


                        if (!title || !content || !categoryId) {
                            e.preventDefault();
                            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                            return false;
                        }

                        // Recommend uploading image
                        if (!imageValue || imageValue.trim() === '') {
                            if (!confirm('Bạn chưa upload ảnh. Có muốn tiếp tục không?')) {
                                e.preventDefault();
                                return false;
                            }
                        }

                    });
                </script>
            </body>

            </html>