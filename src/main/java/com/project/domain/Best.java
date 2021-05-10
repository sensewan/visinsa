package com.project.domain;


public class Best {
	
	private int count;
	private String productName, age;
	
	
	public Best() {}

	public Best(String productName, String age, int count) {
		this.productName = productName;
		this.age = age;
		this.count = count;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}	
	
}
