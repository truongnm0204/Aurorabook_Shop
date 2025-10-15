<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <c:set var="pageTitle" value="Aurora" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <jsp:include page="/WEB-INF/views/layouts/_head.jsp" />
                    <!-- CSS riêng của trang -->
                    <link rel="stylesheet" href="${ctx}/assets/css/catalog/book.css?v=1.0.1">
                </head>

                <body>
                    <jsp:include page="/WEB-INF/views/layouts/_header.jsp" />

                    <div class="container my-4 book">
                        <div class="row">
                            <!-- FILTER -->
                            <div class="col-md-3">
                                <jsp:include page="/WEB-INF/views/catalog/books/partials/_filters.jsp" />
                            </div>

                            <!-- CONTENT -->
                            <div class="col-md-9 book-content">
                                <div class="book-content-header">
                                    <h4 class="book-content-title">
                                        <c:out value="${empty title ? 'Tất cả sản phẩm' : title}" />
                                    </h4>
                                    <c:if test="${showSort}">
                                        <div class="book-content-arrange">
                                            <label class="form-label m-0">Sắp xếp</label>
                                            <select class="form-select" id="sortSelect">
                                                <option value="pop" ${param.sort=='pop' ? 'selected' : '' }>Phổ biến
                                                </option>
                                                <option value="best" ${param.sort=='best' ? 'selected' : '' }>Bán chạy
                                                </option>
                                                <option value="priceAsc" ${param.sort=='priceAsc' ? 'selected' : '' }>
                                                    Giá
                                                    thấp đến cao</option>
                                                <option value="priceDesc" ${param.sort=='priceDesc' ? 'selected' : '' }>
                                                    Giá
                                                    cao đến thấp</option>
                                            </select>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- GRID SẢN PHẨM -->
                                <div class="row g-3 product">
                                    <c:choose>
                                        <c:when test="${empty products}">
                                            <p>${noProductsMessage}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="p" items="${products}">
                                                <div class="col-6 col-md-4 col-lg-3">
                                                    <a href="${ctx}/home?action=detail&id=${p.productId}">
                                                        <div class="product-card">
                                                            <div class="product-img">
                                                                <!-- Tính % giảm giá từ originalPrice và salePrice -->
                                                                <c:if
                                                                    test="${p.salePrice != null && p.originalPrice != null && p.salePrice < p.originalPrice}">
                                                                    <span class="discount">
                                                                        -
                                                                        <fmt:formatNumber value="${p.discountPercent}"
                                                                            maxFractionDigits="0" />%
                                                                    </span>
                                                                </c:if>

                                                                <img src="http://localhost:8080/assets/images/catalog/products/${p.primaryImageUrl}"
                                                                    alt="${p.title}">
                                                            </div>
                                                            <div class="product-body">
                                                                <h6 class="price">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${p.salePrice != null && p.originalPrice != null && p.salePrice < p.originalPrice}">
                                                                            <fmt:formatNumber value="${p.salePrice}"
                                                                                type="currency" currencySymbol="đ"
                                                                                maxFractionDigits="0" />
                                                                            <span
                                                                                class="text-muted text-decoration-line-through ms-2">
                                                                                <fmt:formatNumber
                                                                                    value="${p.originalPrice}"
                                                                                    type="currency" currencySymbol="đ"
                                                                                    maxFractionDigits="0" />
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <fmt:formatNumber value="${p.originalPrice}"
                                                                                type="currency" currencySymbol="đ"
                                                                                maxFractionDigits="0" />
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </h6>

                                                                <small class="author">${p.publisher.name}</small>
                                                                <p class="title">${p.title}</p>
                                                                <div class="rating">
                                                                    <c:forEach begin="1" end="5" var="k">
                                                                        <c:choose>
                                                                            <c:when test="${k <= p.avgRating}">
                                                                                <i
                                                                                    class="bi bi-star-fill text-warning small"></i>
                                                                            </c:when>
                                                                            <c:when test="${k - p.avgRating <= 0.5}">
                                                                                <i
                                                                                    class="bi bi-star-half text-warning small"></i>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <i
                                                                                    class="bi bi-star text-warning small"></i>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>
                                                                    <span>Đã bán ${p.soldCount}</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- PHÂN TRANG -->
                                <c:if test="${totalPages > 1}">
                                    <jsp:include page="/WEB-INF/views/layouts/_pagination.jsp">
                                        <jsp:param name="page" value="${page}" />
                                        <jsp:param name="totalPages" value="${totalPages}" />
                                        <jsp:param name="baseUrl"
                                            value="${ctx}/home?action=${param.action}&keyword=${param.keyword}&category=${param.category}&author=${param.author}&publisher=${param.publisher}&language=${param.language}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}" />
                                    </jsp:include>
                                </c:if>

                            </div>
                        </div>
                    </div>

                    <script>
                        document.getElementById('sortSelect').addEventListener('change', function () {
                            window.location.href = `${window.location.origin}${window.location.pathname}?action=bookstore&sort=` + this.value + "&page=1";
                        });
                    </script>

                    <jsp:include page="/WEB-INF/views/layouts/_footer.jsp" />
                    <jsp:include page="/WEB-INF/views/layouts/_scripts.jsp" />
                </body>

                </html>