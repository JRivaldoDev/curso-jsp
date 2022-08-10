package beandto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class BeanDtoSalarioUser implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private List<Double> medias = new ArrayList<Double>();
	private List<String> perfis = new ArrayList<String>();
	
	public List<Double> getMedias() {
		return medias;
	}
	public void setMedias(List<Double> medias) {
		this.medias = medias;
	}
	public List<String> getPerfis() {
		return perfis;
	}
	public void setPerfis(List<String> perfis) {
		this.perfis = perfis;
	}

}
