package com.project.domain;

public class MainBody {

	private String symptomName, symptomCode, bodyCode;
	
	public MainBody() { }
	

	public MainBody(String symptomName, String symptomCode, String bodyCode) {
		this.symptomName = symptomName;
		this.symptomCode = symptomCode;
		this.bodyCode = bodyCode;
	}


	public String getSymptomCode() {
		return symptomCode;
	}

	public void setSymptomCode(String symptomCode) {
		this.symptomCode = symptomCode;
	}

	public String getBodyCode() {
		return bodyCode;
	}

	public void setBodyCode(String bodyCode) {
		this.bodyCode = bodyCode;
	}

	public String getSymptomName() {
		return symptomName;
	}

	public void setSymptomName(String symptomName) {
		this.symptomName = symptomName;
	}
	
}