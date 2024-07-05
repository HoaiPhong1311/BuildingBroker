package com.javaweb.service;

import com.javaweb.model.dto.TransactionDTO;

public interface TransactionService {
    void addOrUpdateTransaction(TransactionDTO transaction);

    TransactionDTO getTransactionById(Long id);
}