;;;; Extract the content of a PDF file as text using the PDFBox library

;; Add the PDFBox library to the CLASSPATH
(add-to-classpath "./lib/pdfbox-app-2.0.21.jar")

;; Import the File, PDDocument and PDFTextStripper classes
(defconstant +file+ (jclass "java.io.File"))
(defconstant +pd-document+ (jclass "org.apache.pdfbox.pdmodel.PDDocument"))
(defconstant +pdf-text-stripper+ (jclass "org.apache.pdfbox.text.PDFTextStripper"))

;; Import the methods we will use
(defconstant +load+ (jmethod +pd-document+ "load" +file+))
(defconstant +get-text+ (jmethod +pdf-text-stripper+ "getText" +pd-document+))

;; Define the function to extract the content of a PDF file
(defun extract-text-from-pdf (filepath)
  "Given the path of a PDF file, extract its content as text."
  (let* ((file (jnew +file+ filepath))
         (document (jstatic +load+ +pd-document+ file))
         (text (jcall +get-text+ (jnew +pdf-text-stripper+) document)))
    text))

;; Test the function extracting the content of the file "test.pdf"
(extract-text-from-pdf "./test.pdf")
