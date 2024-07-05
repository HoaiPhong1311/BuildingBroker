package com.javaweb.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@Setter
@Table(name = "transaction")
public class TransactionEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "code")
    private String code;

    @Column(name = "note")
    private String transactionDetail;

    @Column(name = "customerid")
    private String customerId;

    @Column(name = "createddate")
    private Date createdDate;

    @Column(name = "modifieddate")
    private Date modifiedDate;

    @Column(name = "createdby")
    private String createdBy;

    @Column(name = "modifiedby")
    private String modifiedBy;

    @Column(name = "staffid")
    private String staffId;
}
