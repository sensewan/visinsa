package com.project.domain;

public class MainBody {

	private String symptomName;
	
	public MainBody() { }
	
	public MainBody(String symptomName) {
		this.symptomName = symptomName;
	}

	public String getSymptomName() {
		return symptomName;
	}

	public void setSymptomName(String symptomName) {
		this.symptomName = symptomName;
	}
	
}