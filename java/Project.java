
import java.sql.Date;

public class Project {
    private int project_id;
    private String project_name;
    private Date start_date;
    private Date end_date;
    private String description;

    // Default Constructor
    public Project() {}

    // Parameterized Constructor
    public Project(int project_id, String project_name, Date start_date, 
                   Date end_date, String description) {
        this.project_id = project_id;
        this.project_name = project_name;
        this.start_date = start_date;
        this.end_date = end_date;
        this.description = description;
    }

    // Getters and Setters
    public int getProject_id() { return project_id; }
    public void setProject_id(int project_id) { this.project_id = project_id; }

    public String getProject_name() { return project_name; }
    public void setProject_name(String project_name) { this.project_name = project_name; }

    public Date getStart_date() { return start_date; }
    public void setStart_date(Date start_date) { this.start_date = start_date; }

    public Date getEnd_date() { return end_date; }
    public void setEnd_date(Date end_date) { this.end_date = end_date; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
