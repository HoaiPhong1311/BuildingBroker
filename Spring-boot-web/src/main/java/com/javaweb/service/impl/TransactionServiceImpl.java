package com.javaweb.service.impl;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.service.TransactionService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    @Transactional
    public void addOrUpdateTransaction(TransactionDTO transaction) {
        TransactionEntity transactionEntity;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();

            if (transaction.getId() == null) {
                transactionEntity = new TransactionEntity();
                transactionEntity.setCreatedDate(new Date());
                transactionEntity.setCreatedBy(userDetails.getUsername());
                transactionEntity.setCustomerId(transaction.getCustomerId());
                transactionEntity.setCode(transaction.getCode());
            } else {
                transactionEntity = transactionRepository.findById(transaction.getId()).get();
                transactionEntity.setModifiedDate(new Date());
                transactionEntity.setModifiedBy(userDetails.getUsername());
            }

            transactionEntity.setTransactionDetail(transaction.getTransactionDetail());
            transactionRepository.save(transactionEntity);

        }
    }

    @Override
    public TransactionDTO getTransactionById(Long id) {
        TransactionEntity transaction = transactionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Transaction not found"));
        return modelMapper.map(transaction, TransactionDTO.class);
    }
}
