import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author asus tuf
 */
@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assuming DAO classes have methods to get required statistics
        int speciesCount = Species.getSpeciesCount();
        int projectCount = Project.getActiveProjectCount();
        double totalDonations = Donation.getTotalDonations();

        request.setAttribute("speciesCount", speciesCount);
        request.setAttribute("projectCount", projectCount);
        request.setAttribute("totalDonations", totalDonations);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
