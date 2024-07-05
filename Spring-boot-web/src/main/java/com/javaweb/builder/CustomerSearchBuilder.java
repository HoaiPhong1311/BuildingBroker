package com.javaweb.builder;



public class CustomerSearchBuilder {
    private String fullName;
    private String phone;
    private String email;
    private String status;
    private String staffId;

    public CustomerSearchBuilder(Builder builder) {
        this.fullName = builder.fullName;
        this.phone = builder.phone;
        this.email = builder.email;
        this.status = builder.status;
        this.staffId = builder.staffId;
    }

    public String getFullName() {return fullName;}
    public String getPhone() {return phone;}
    public String getEmail() {return email;}
    public String getStatus() {return status;}
    public String getStaffId() {return staffId;}

    public static class Builder {
        private String fullName;
        private String phone;
        private String email;
        private String status;
        private String staffId;

        public Builder setFullName(String fullName) {
            this.fullName = fullName;
            return this;
        }
        public Builder setPhone(String phone) {
            this.phone = phone;
            return this;
        }
        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }
        public Builder setStatus(String status) {
            this.status = status;
            return this;
        }
        public Builder setStaffId(String staffId) {
            this.staffId = staffId;
            return this;
        }

        public CustomerSearchBuilder build() { return new CustomerSearchBuilder(this);}
    }
}
