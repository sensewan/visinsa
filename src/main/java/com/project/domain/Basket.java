package com.project.domain;

public class Basket {
	
	private int num, count, price, productPrice;
	private String id, productName, image;
	
	public Basket() {}

	public Basket(int num, String id, int count) {
		this.count = count;
		this.num = num;
		this.id = id;
	}
	
	public Basket(int num, String id, int count,
			String productName, String image, int productPrice, int price) {
		this.count = count;
		this.num = num;
		this.id = id;
		this.productName = productName;
		this.image = image;
		this.productPrice = productPrice;
		this.price = price;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}