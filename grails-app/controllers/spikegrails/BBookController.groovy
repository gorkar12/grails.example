package spikegrails

class BBookController {

    static scaffold = BBook

    def setup() {
        render """<pre>
        Ahora hay ${BBook.count()} libros y ${BAuthor.count()} autores.

        ${g.link(controller:'BBook', action: 'load') {'Cargar datos de prueba'}}
        ${g.link(controller:'BBook', action: 'deleteall') {'Borrar los datos'}}

        Libros clasificados X:
        ${obtenerLibrosX()}

        </pre>"""

    }

    def load() {
        new BAuthor(name:"Stephen King")
                .addToBooks(new BBook(title:"The Stand"))
                .save(failOnError:true, flush: true)
        (1..10).each { it ->
            new BAuthor(name: "Autor ${it}").addToBooks(new BBook(title:"Libro ${it}")).save()
        }

        (1..10).each { b ->
            new BBook(title: "X - Libro ${b}").save(failOnError:true)
        }

        render "He llamado al setup!"
        redirect(controller: "BBook", action: "setup")
    }

    def deleteall(){
        BBook.list().each { libro ->
            libro.delete()
        }
        BAuthor.list().each { autor ->
            autor.delete()
        }
        redirect(controller: "BBook", action: "setup")
    }

    def verlibro(Integer id) {
        def libro = BBook.get(id)
        render """<pre>
        Titulo: ${libro.title}
        Autor: ${libro.author?:'Desconocido'}
            Otras obras:${librosDelAutor(libro.author)}
        </pre>"""
    }

    private librosDelAutor(autor) {
        autor?.books.inject("") {p, b ->
            p << "--> ${b.title} (${b.id})\n"
        }
    }

    private obtenerLibrosX() {
        def datos= BBook.findAllByTitleLike('X%').inject("") { p, s ->
            def link = g.link(action: 'verlibro', id: s.id) {"Ver"}
            p << "* ${s.title} - [${link}]\n"
        }
    }
}
