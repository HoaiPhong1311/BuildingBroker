package com.javaweb.entity;


import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "customer")
@Getter
@Setter
public class CustomerEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "fullname")
    private String fullName;

    @Column(name = "phone")
    private String phone;

    @Column(name = "email")
    private String email;

    @Column(name = "companyname")
    private String companyName;

    @Column(name = "demand")
    private String demand;

    @Column(name = "status")
    private String status;

    @Column(name = "is_active")
    private String activeStatus;

    @Column(name = "createddate")
    private Date createdDate;

    @Column(name = "modifieddate")
    private Date modifiedDate;

    @Column(name = "createdby")
    private String createdBy;

    @Column(name = "modifiedby")
    private String modifiedBy;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "assignmentcustomer",
            joinColumns = @JoinColumn(name = "customerid", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "staffid", nullable = false))
    private List<UserEntity> userCus = new ArrayList<>();
}
