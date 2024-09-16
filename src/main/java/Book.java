
public class Book {
    private String bookCode;
    private String bookName;
    private String authorName;
    private int noOfCopies;
    private String additionalInfo;
    
    
    

    public Book() {
		super();
	}

	public Book(String bookCode, String bookName, String authorName, int noOfCopies, String additionalInfo) {
		super();
		this.bookCode = bookCode;
		this.bookName = bookName;
		this.authorName = authorName;
		this.noOfCopies = noOfCopies;
		this.additionalInfo = additionalInfo;
	}

	// Getters and setters
    public String getBookCode() {
        return bookCode;
    }

    public void setBookCode(String bookCode) {
        this.bookCode = bookCode;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public int getNoOfCopies() {
        return noOfCopies;
    }

    public void setNoOfCopies(int noOfCopies) {
        this.noOfCopies = noOfCopies;
    }

    public String getAdditionalInfo() {
        return additionalInfo;
    }

    public void setAdditionalInfo(String additionalInfo) {
        this.additionalInfo = additionalInfo;
    }
}
