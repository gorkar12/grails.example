package spikegrails

class BBook {
	String title
	BAuthor author

    static constraints = {
        author(nullable: true)
    }

     @Override public String toString() {
        return this.title
    }
}
