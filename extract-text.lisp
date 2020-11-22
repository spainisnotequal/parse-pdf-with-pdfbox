;;;; Extract the content of a PDF file as text using the PDFBox library

;;; Replicate the following Java example:
;;;     import java.io.File;
;;;     import java.io.IOException;
;;;      
;;;     import org.apache.pdfbox.pdmodel.PDDocument;
;;;     import org.apache.pdfbox.text.PDFTextStripper;
;;;      
;;;     public class ExtractText {
;;;      
;;;         public static void main(String[] args) {
;;;             try {
;;;                 PDDocument doc = PDDocument.load(new File("sample.pdf"));
;;;                 String text = new PDFTextStripper().getText(doc);;
;;;                 System.out.println("Text in PDF\n---------------------------------");
;;;                 System.out.println(text);
;;;                 } catch (IOException e) {
;;;                 e.printStackTrace();
;;;             }
;;;         }
;;;     }

;; Add the PDFBox library to the CLASSPATH
(add-to-classpath "/opt/java/pdfbox-app-2.0.21.jar")

;; Import the File, PDDocument and PDFTextStripper classes
(defconstant +file+ (jclass "java.io.File"))
(defconstant +pd-document+ (jclass "org.apache.pdfbox.pdmodel.PDDocument"))
(defconstant +pdf-text-stripper+ (jclass "org.apache.pdfbox.text.PDFTextStripper"))

;;; Wrap both static methods and instance methods into Lisp functions
(defun load-document (filepath)
  (let ((file (jnew +file+ filepath)))
    (jstatic (jmethod +pd-document+ "load" +file+) +pd-document+ file)))

(defun get-text (document)
  (let ((text (jnew +pdf-text-stripper+)))
    (jcall (jmethod +pdf-text-stripper+ "getText" +pd-document+) text document)))

;; Define the function to extract the content of a PDF file
(defun extract-text-from-pdf (filepath)
  "Given the path of a PDF file, extract its content as text."
  (let ((document (load-document filepath)))
    (get-text document)))

;; Test the function extracting the content of the file "test.pdf"
(extract-text-from-pdf "./test.pdf")
