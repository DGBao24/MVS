
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <title>Sign Up</title>
    </head>
    <body>
        <div class="bg-light py-3 py-md-5">
            <div class="container">
                <div class="row justify-content-md-center">
                    <div class="col-12 col-md-11 col-lg-8 col-xl-7 col-xxl-6">
                        <div class="bg-white p-4 p-md-5 rounded shadow-sm">
                            <div class="row">
                                <div class="col-12">
                                    <div class="mb-4">
                                        <h3>Sign Up</h3>
                                        <% if (request.getAttribute("mess") != null) { %>

                                        <div class="alert alert-danger mt-3">
                                            <%= request.getAttribute("mess") %>
                                        </div>

                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            <form action="signup" method="post">
                                <div class="row gy-3 gy-md-4">
                                    <div class="col-12">
                                        <label for="name" class="form-label">Full Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" name="password" id="password" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="confirm_password" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" name="confirm_password" id="confirm_password" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="phone" class="form-label">Phone Number <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="phone" id="phone" placeholder="123-456-7890" required>
                                    </div>
                                    <div class="col-12">

                                        <label>Gender:</label>
                                        <select name="Gender" required class="form-control">
                                            <option value="Male" >Male</option>
                                            <option value="Female" >Female</option>
                                            <option value="Others" >Others</option>
                                        </select>
                                    </div>
                                    <div class="col-12">

                                        <label for="address" class="form-label">Address <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="address" id="address" placeholder="123 Main St, City, Country" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="yearOfBirth" class="form-label">Year of Birth <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" name="yearOfBirth" id="yearOfBirth" min="1900" max="<%= java.time.Year.now().getValue() - 10 %>" required>
                                    </div>
                                    <div class="col-12">
                                        <div class="d-grid">
                                            <button class="btn btn-lg btn-primary" type="submit">Sign Up</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <div class="row">
                                <div class="col-12">
                                    <hr class="mt-5 mb-4 border-secondary-subtle">
                                    <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-end">
                                        <a href="login.jsp" class="link-secondary text-decoration-none">Already have an account? Log in</a>
                                    </div>
                                </div>
                            </div>

                        </div> <!-- End of form container -->
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
