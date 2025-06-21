public class Main {
    public static void main(String[] args) {
        DocumentFactory factory;

        factory = new WordDocumentFactory();
        Document word = factory.createDocument();
        word.open();

        factory = new PdfDocumentFactory();
        Document pdf = factory.createDocument();
        pdf.open();

        factory = new ExcelDocumentFactory();
        Document excel = factory.createDocument();
        excel.open();
    }
}

