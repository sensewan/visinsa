package com.project.domain;

public class MainBody {

	private String symptomName, symptomCode, bodyCode, 
		medicalCode, diseaseName, medicalName;
	
	public MainBody() { }
	

	public MainBody(String symptomName, String symptomCode, String bodyCode) {
		this.symptomName = symptomName;
		this.symptomCode = symptomCode;
		this.bodyCode = bodyCode;
	}
	
	
	public MainBody(String diseaseName, String medicalName) {
		this.diseaseName = diseaseName;
		this.medicalName = medicalName;
	}


	public String getMedicalName() {
		return medicalName;
	}


	public void setMedicalName(String medicalName) {
		this.medicalName = medicalName;
	}


	public String getMedicalCode() {
		return medicalCode;
	}


	public void setMedicalCode(String medicalCode) {
		this.medicalCode = medicalCode;
	}


	public String getDiseaseName() {
		return diseaseName;
	}


	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
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