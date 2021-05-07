package com.project.domain;

import java.sql.Timestamp;

public class Product {
	
	private int no;
	private String productCode;
	private String productName;
	private String typicalIngredient;   // 대표성분  
	private String typicalFunction;     // 대표기능
	private int productPrice;
	private String productBrand;
	private String productExplain;
	private String image;
	private Timestamp regDate;
	private Timestamp modDate;
	
	
	public Product() {}


	public Product(int no, String productCode, String productName, String typicalIngredient, String typicalFunction,
		int productPrice, String productBrand, String productExplain, String image, Timestamp regDate,
		Timestamp modDate) {
	this.no = no;
	this.productCode = productCode;
	this.productName = productName;
	this.typicalIngredient = typicalIngredient;
	this.typicalFunction = typicalFunction;
	this.productPrice = productPrice;
	this.productBrand = productBrand;
	this.productExplain = productExplain;
	this.image = image;
	this.regDate = regDate;
	this.modDate = modDate;
}

	

	public String getProductExplain() {
		return productExplain;
	}


	public void setProductExplain(String productExplain) {
		this.productExplain = productExplain;
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getProductCode() {
		return productCode;
	}


	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getTypicalIngredient() {
		return typicalIngredient;
	}


	public void setTypicalIngredient(String typicalIngredient) {
		this.typicalIngredient = typicalIngredient;
	}


	public String getTypicalFunction() {
		return typicalFunction;
	}


	public void setTypicalFunction(String typicalFunction) {
		this.typicalFunction = typicalFunction;
	}


	public int getProductPrice() {
		return productPrice;
	}


	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}


	public String getProductBrand() {
		return productBrand;
	}


	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public Timestamp getRegDate() {
		return regDate;
	}


	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}


	public Timestamp getModDate() {
		return modDate;
	}


	public void setModDate(Timestamp modDate) {
		this.modDate = modDate;
	}

	
	

	


}
