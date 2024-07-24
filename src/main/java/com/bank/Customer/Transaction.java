package com.bank.Customer;

public class Transaction {
    private String transactionType;
    private double amount;
    private String date;
    private String type;
    private double balance;

    // Constructor
    public Transaction(String transactionType, double amount, String date, String type, double balance) {
        this.transactionType = transactionType;
        this.amount = amount;
        this.date = date;
        this.type = type;
        this.balance = balance;
    }

    public Transaction() {
		// TODO Auto-generated constructor stub
	}

	// Getters and setters
    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }
}
