public class Species {

    static int getSpeciesCount() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    private String speciesName;
    private String scientificName;
    private String endangeredStatus;
    private String habitat;
    private int speciesId;

    // Getters and Setters for the above fields
    public String getSpeciesName() {
        return speciesName;
    }

    public void setSpeciesName(String speciesName) {
        this.speciesName = speciesName;
    }

    public String getScientificName() {
        return scientificName;
    }

    public void setScientificName(String scientificName) {
        this.scientificName = scientificName;
    }

    public String getEndangeredStatus() {
        return endangeredStatus;
    }

    public void setEndangeredStatus(String endangeredStatus) {
        this.endangeredStatus = endangeredStatus;
    }

    public String getHabitat() {
        return habitat;
    }

    public void setHabitat(String habitat) {
        this.habitat = habitat;
    }

    public int getSpeciesId() {
        return speciesId;
    }

    public void setSpeciesId(int speciesId) {
        this.speciesId = speciesId;
    }
}
