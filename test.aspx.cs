using GoGetIt.MyServices;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using GoGetIt.Model;
using System.Configuration;
using System.Net.Mail;
using System.Net.Mime;
using DotNetNuke.Services.Exceptions;

namespace GoGetIt
{
    public partial class Test : System.Web.UI.Page
    {
        private DBEntities db = new DBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            DriverController oc = new DriverController();
            var vrReport = oc.List();
            */
            /*
            Distance d = new Distance("3401 N Miami Ave, Miami, FL 33127 MIAMI Florida", "1935 West Ave #204 33139 MIAMI BEACH Florida");
            d.GetDrivingDistanceInMiles();
            */
            //DriverController dc = new DriverController();
            //dc.SetDeviceToken("ABC");

            /*
            PushNotification o = new PushNotification();
            o.SendNotification("New Job");
            */
            //OrderController oc = new OrderController();
            //oc.AdminList(new SearchInfoMember<string> { data="cancelled", });
            /*var v = oc.Get(5);*/
            //var v = oc.List(new SearchInfoMember<string> { data="unassigned", pageIndex=0, pageSize=10 });
            //int i = 0;

            //oc.ReOrder(242);

            //ComputeDistance();
            //GetDrivingDistanceInMiles(Server.UrlEncode("Seattle"), Server.UrlEncode("San Francisco"));

            //GetDrivingDistanceInMiles(Server.UrlEncode("11 Gumasta Nagar Indore MP 452009"), Server.UrlEncode("Inox Sapna Sangeeta Road Indore MP 452001"));
            //Distance dist = new Distance(3585);
            //dist.GetDrivingDistanceInMiles();

            //DBEntities db = new DBEntities();
            //int orderid = Convert.ToInt32(3594);
            //GRI_Order oOrder = db.GRI_Order.FirstOrDefault(d => d.OrderID == orderid);
            //SendEmail.EmailNotification.Order(oOrder, "jcarranza@gmail.com", "5262", Convert.ToDecimal(0.00), Convert.ToDecimal(2.18), Convert.ToDecimal(10.90));
            //SendEmail.EmailNotification.ForgotPassword("Jose", "Carranza", "sitio", "lexn29@gmail.com");

/*
            GRI_Order oOrder = db.GRI_Order.FirstOrDefault(d => d.OrderID == 8913);
            String email = "gogetitassistance@gmail.com";
            String last4 = "3902";
            Decimal amount1 = Utility.GetDecimal(625.95);
            Decimal amount2 = Utility.GetDecimal(59.25);
            Decimal amount3 = Utility.GetDecimal(685.20);


            SendEmail.EmailNotification.Order(oOrder, email, last4, amount1, amount2, amount3);

            oOrder = db.GRI_Order.FirstOrDefault(d => d.OrderID == 8914);
             email = "drobles@letusgogetit.com";
             last4 = "3902";
             amount1 = Utility.GetDecimal(524.30);
             amount2 = Utility.GetDecimal(20.00);
             amount3 = Utility.GetDecimal(592.35);


            SendEmail.EmailNotification.Order(oOrder, email, last4, amount1, amount2, amount3);

            
            decimal rate = Utility.GetDecimal(ConfigurationManager.AppSettings["ItemAmount"]);
            decimal DELIVERYFEE = 10;
            decimal ProcessingFee = 10;
            List<GoGetIt.SendEmail.EmailDictionary> lstDictionary = new List<GoGetIt.SendEmail.EmailDictionary>();
            try
            {
                AddressController ac = new AddressController();
                var pickup = ac.GetAddressByID(oOrder.PickUpAddressID);
                var delivery = ac.GetAddressByID(oOrder.DeliveryAddressID);
                ZipCodeController zc = new ZipCodeController();
                var delievryZip = zc.GetZipCodeByID(delivery.ZipCodeID);
                var pickupZip = zc.GetZipCodeByID(pickup.ZipCodeID);
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[PICKUPNAME]", oOrder.PickUpName));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[DELIVERYNAME]", oOrder.DeliveryName));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[ORDERDATE]", oOrder.DateCreated.ToShortDateString()));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[ORDERTIME]", oOrder.DateCreated.ToShortTimeString()));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[ORDERDETAIL]", oOrder.Details));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[PICKUPADDRESS1]", pickup.Address1));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[PICKUPADDRESS2]", pickup.Address2));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[PICKUPZIP]", pickupZip.ZipCode));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[DELIVERYADDRESS1]", delivery.Address1));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[DELIVERYADDRESS2]", delivery.Address2));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[DELIVERYZIP]", delievryZip.ZipCode));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[COSTOFITEM]", "100"));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[DELIVERYFEE]", DELIVERYFEE.ToString()));

                //lstDictionary.Add(new EmailDictionary("[PROCESSINGFEE]", String.Format("{0:0.00}", ProcessingFee)));
                //lstDictionary.Add(new EmailDictionary("[MILESANDTIME]", String.Format("{0:0.00}", TimeAndMile)));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[TIP]", "10"));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[TOTAL]", "10"));
                lstDictionary.Add(new GoGetIt.SendEmail.EmailDictionary("[LAST4]", "1234"));
            }
            catch (Exception ex) {
              // poner excepcion aqui. 
            }
            SendEmail(GoGetIt.SendEmail.EmailTemplate.Order, lstDictionary, "jcarranza@gmail.com");
    /*
            string sPath = ConfigurationManager.AppSettings["EmailTemplatePath"].ToString();
            sPath += GoGetIt.SendEmail.EmailTemplate.Order.ToString() + ".htm";
            MailMessage oEmail = new MailMessage();
            oEmail.From = new MailAddress("gogetit@letusgogetit.com");
            oEmail.To.Add(new MailAddress("jcarranza@gmail.com"));
            string emailtemplate = File.ReadAllText(sPath);
            string sSubject = "";


             foreach (GoGetIt.SendEmail.EmailDictionary oDictionary in lstDictionary)
                    {
                        emailtemplate = emailtemplate.Replace(oDictionary.Key, oDictionary.Value);
                    }
                    switch (GoGetIt.SendEmail.EmailTemplate.Order.ToString())
                    {

                        case "ThankYou":
                            sSubject = "Thank you for contacting GoGetIt.com";
                            break;
                        case "ClientSignUp":
                            sSubject = "Welcome to GoGetIt.com";
                            break;
                        case "Order":
                            sSubject = "Thank you for your business with GoGetIt.com";
                            break;
                        case "OrderPlaced":
                            sSubject = "Thank you for your order on GoGetIt.com";
                            break;
                        case "ForgotPassword":
                            sSubject = "Reset your GoGetIt.com password";
                            break;
                        case "Contact":
                            sSubject = "Contact from website";
                            break;
                            
                        default:
                            break;


                    }
            try{
                    oEmail.Subject = sSubject;
                    oEmail.Body = emailtemplate;
                    oEmail.IsBodyHtml = true;


                    SmtpClient mSmtpClient = new SmtpClient();
                    mSmtpClient.Host = "mail.letusgogetit.com";
                    mSmtpClient.Port = 587;
                    mSmtpClient.EnableSsl = false;
                    mSmtpClient.UseDefaultCredentials = false;

                    mSmtpClient.Credentials = new NetworkCredential("gogetit@letusgogetit.com", "S*]X7q=]cEnO");


                    try
                    {
                        mSmtpClient.Send(oEmail);
                    }
                    catch (Exception ex)
                    {
                        Exceptions.LogException(ex);
                    }
                }
                catch (Exception ex)
                {
                    Exceptions.LogException(ex);
                }
            */



        }

            /*
        void ComputeDistance()
        {
            var request = WebRequest.Create("https://maps.googleapis.com/maps/api/distancematrix/json?origins=Seattle&destinations=San+Francisco");
            // Indicate you are looking for a JSON response
            request.ContentType = "application/json; charset=utf-8";
            var response = (HttpWebResponse)request.GetResponse();

            // Read through the response
            using (var sr = new StreamReader(response.GetResponseStream()))
            {
                // Define a serializer to read your response
                JavaScriptSerializer serializer = new JavaScriptSerializer();

                // Get your results
                dynamic result = serializer.DeserializeObject(sr.ReadToEnd());

                // Read the distance property from the JSON request
                var distance = result["rows"][0]["elements"][0]["distance"]["text"]; // yields "1,300 KM"

                int i = 0;
            }
        }



        public object AttachmentFilename { get; set; }
        */
    }
}