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

;;; Wrap both static methods and instance methods into Lisp functions
(defun load-document (filepath)
  (let* ((File (jclass "java.io.File"))
         (PDDocument (jclass "org.apache.pdfbox.pdmodel.PDDocument"))
         (new-file (jnew File filepath)))
    (jstatic (jmethod PDDocument "load" File) PDDocument new-file)))

(defun get-text (document)
  (let* ((PDDocument (jclass "org.apache.pdfbox.pdmodel.PDDocument"))
         (PDFTextStripper (jclass "org.apache.pdfbox.text.PDFTextStripper"))
         (text (jnew PDFTextStripper)))
    (jcall (jmethod PDFTextStripper "getText" PDDocument) text document)))

;; Define the function to extract the content of a PDF file
(defun extract-text-from-pdf (filepath)
  "Given the path of a PDF file, extract its content as text."
  (let ((document (load-document filepath)))
    (get-text document)))

;; Test the function extracting the content of the file "test.pdf"
(extract-text-from-pdf "./test.pdf")
