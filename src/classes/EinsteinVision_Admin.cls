public class EinsteinVision_Admin {
	DB_AttachmentSelector attachmentSelector;
	DB_CatSelector catSelector;
	DB_GenericDml genericDml;
	EinsteinVision_PredictionService predictionService;
	
	public EinsteinVision_Admin(
			DB_AttachmentSelector attachmentSelector, 
			DB_CatSelector catSelector, 
			DB_GenericDml genericDml, 
			EinsteinVision_PredictionService predictionService
		) {
		this.attachmentSelector = attachmentSelector;
		this.catSelector = catSelector;
		this.genericDml = genericDml;
		this.predictionService = predictionService;
	}
	

	public EinsteinVision_Admin() {
		this(
			new DB_AttachmentSelector(), 
			new DB_CatSelector(), 
			new DB_GenericDml(), 
			new EinsteinVision_PredictionService()
		);
	}
	
	// --------------------------------------------------------------------------
	
	@AuraEnabled
	public static void createDatasetFromUrl(String zipUrl) {
		(new EinsteinVision_Admin()).createDatasetFromUrlAsync(zipUrl);
	}    
	
	@testVisible
	private void createDatasetFromUrlAsync(String zipUrl) {
		this.predictionService.createDatasetFromUrlAsync(zipUrl);
	}
	
	// --------------------------------------------------------------------------

	@AuraEnabled
	public static List<EinsteinVision_Dataset> getDatasets() {
		return (new EinsteinVision_Admin()).getDatasetList();
	}

	@testVisible
	private List<EinsteinVision_Dataset> getDatasetList() {
		return this.predictionService.getDatasets();
	}

	// --------------------------------------------------------------------------

	@AuraEnabled
	public static String trainDataset(Decimal datasetId) {
		return (new EinsteinVision_Admin()).trainDatasetOnService((Long)datasetId);
	}

	@testVisible
	private String trainDatasetOnService(Long datasetId) {
		return this.predictionService.trainDataset(datasetId, 'Training', 0, 0, '').modelId;
	}

	// --------------------------------------------------------------------------

	@AuraEnabled
	public static void deleteDataset(Long datasetId) {
		(new EinsteinVision_Admin()).deleteDatasetFromService(datasetId);
	}

	@testVisible
	private void deleteDatasetFromService(Long datasetId) {
		this.predictionService.deleteDataset(datasetId);
	} 

	// --------------------------------------------------------------------------

	@AuraEnabled
	public static List<EinsteinVision_Model> getModels(Long datasetId) {
		return (new EinsteinVision_Admin()).getModelListFromService(datasetId);
	}

	@testVisible
	private List<EinsteinVision_Model> getModelListFromService(Long datasetId) {
		return this.predictionService.getModels(datasetId);
	} 

	// --------------------------------------------------------------------------

	@AuraEnabled
	public static void getCatPrediction(Id catId, String fileName, String base64) {
		(new EinsteinVision_Admin()).setCatPrediction(catId, fileName, base64);
	}
	
	@testVisible 
	private void setCatPrediction(Id catId, String fileName, String base64) {
		Blob fileBlob = EncodingUtil.base64Decode(base64);
		String catBreed = this.findCatBreed(fileBlob);
		if (!String.isBlank(catBreed)) {
			Cat__c cat = catSelector.selectById(new Set<Id>{catId})[0];
			cat.Cat_Breed__c = catBreed;
			this.genericDml.doUpdate(new List<Cat__c>{cat});
			this.replaceAttachment(catId, fileName, fileBlob);		
		}
	}
	
	@testVisible String findCatBreed(Blob fileBlob) {
		List<EinsteinVision_Dataset> datasetList = this.predictionService.getDatasets();
		for (EinsteinVision_Dataset dataset : datasetList) {
			if (dataset.Name.equals('Cats')) {
				EinsteinVision_Model model = this.predictionService.getModels(dataset).get(0);
				return predictionService.predictBlob(model.modelId, fileBlob, '')
					.probabilities.get(0)
					.label;
			}
		}
		return null;
	}
	
	@testVisible
	private void replaceAttachment(Id catId, String fileName, Blob fileBlob) {
		List<Attachment> attachmentList = this.attachmentSelector.selectByParentId(new Set<Id>{catId});
		this.genericDml.doDelete(attachmentList);
		this.genericDml.doInsert(new List<Attachment>{new Attachment(
				name = fileName,
				body = fileBlob,
				parentId = catId
			)});
	} 

	// --------------------------------------------------------------------------
	
	@AuraEnabled
	public static List<EinsteinVision_Label> getCatLabels() {
		return (new EinsteinVision_Admin()).getCatLabelList();
	}

	@testVisible
	private List<EinsteinVision_Label> getCatLabelList() {
		List<EinsteinVision_Dataset> datasetList = this.predictionService.getDatasets();
		for (EinsteinVision_Dataset dataset : datasetList) {
			if (dataset.Name.equals('Cats')) {
				return dataset.labelSummary.labels;
			}
		}		
		return null;
	} 
	
	// --------------------------------------------------------------------------
	
	@AuraEnabled
	public static String getImageUrlFromAttachment(Id catId) {
		return (new EinsteinVision_Admin()).getCatAttachmentId(catId);
	}

	@testVisible
	private Id getCatAttachmentId(Id catId) {
		List<Attachment> attachmentList = this.attachmentSelector.selectByParentId(new Set<Id>{catId});
		return (attachmentList.size() > 0)
			? attachmentList.get(0).id
			: null;
	} 
}