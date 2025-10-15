<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- Modal Voucher Cart -->
    <div class="modal fade cart-system-voucher" id="voucherModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Aurora Khuyến Mãi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3 align-items-center">
                        <div class="col-8">
                            <input type="text" class="form-control" placeholder="Nhập mã giảm giá">
                        </div>
                        <div class="col-4">
                            <button class="button-four w-100">Áp dụng</button>
                        </div>
                    </div>

                    <h6 class="fw-bold mb-2">Mã Giảm Giá</h6>
                    <div class="list-group">
                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-success">Aurora</span>
                                <span class="ms-2">Giảm 8% tối đa 30K</span><br>
                                <small>Cho đơn từ 199K - HSD: 25/08/25</small>
                            </div>
                            <input type="radio" name="voucherDiscount" value="discount1" data-text="Giảm 8% tối đa 30K"
                                data-discount="8" data-type="percent" data-max="30000" data-min-order-amount="199000">
                        </label>
                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-success">TIKI</span>
                                <span class="ms-2">Giảm 15K</span><br>
                                <small>Cho đơn từ 199K - HSD: 25/08/25</small>
                            </div>
                            <input type="radio" name="voucherDiscount" value="discount2" data-text="Giảm 15K"
                                data-discount="15000" data-min-order-amount="199000">

                        </label>
                    </div>

                    <h6 class="fw-bold mt-4 mb-2">Mã Vận Chuyển</h6>
                    <div class="list-group">
                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-primary">FREESHIP</span>
                                <span class="ms-2">Giảm 30K</span><br>
                                <small>Cho đơn từ 1đ - HSD: 31/08/25</small>
                            </div>
                            <input type="radio" name="voucherShip" value="ship1" data-text="Giảm 30K" data-ship="30000"
                                data-min-order-amount="1000">
                        </label>

                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-primary">FREESHIP</span>
                                <span class="ms-2">Giảm 25K</span><br>
                                <small>Cho đơn từ 100K - HSD: 25/08/25</small>
                            </div>
                            <input type="radio" name="voucherShip" value="ship2" data-text="Giảm 25K" data-ship="25000"
                                data-min-order-amount="100000">
                        </label>
                    </div>
                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="button-five" data-bs-dismiss="modal">Trở lại</button>
                    <button type="button" class="button-four" id="confirmVoucher">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--End Modal Voucher Cart -->