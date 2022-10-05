<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,net.ucanaccess.jdbc.*" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link  rel="icon"   href="https://cdn-icons-png.flaticon.com/512/29/29302.png" type="image/png" />
  <title>Guía52C-Grupo3</title>
  <link rel="stylesheet" href="style.css">

  <script type="text/javascript">//Funcion Actualizar
  function actualizar(b, x)
  {
    document.getElementById("id_isbn").value=document.getElementById("isbn_id"+b.id).innerHTML;
    document.getElementById("id_titulo").value=document.getElementById("titulo_id"+b.id).innerHTML;
    document.getElementById("id_autor").value=document.getElementById("autor_id"+b.id).innerHTML;
    document.getElementById("id_editorial").options[x-1].selected = 'selected';
    document.getElementById("id_anioPublic").value=document.getElementById("anioPublic_id"+b.id).innerHTML;
    document.getElementById("id_Actualizar").checked=true;
  }
  </script>

  <script>//Script para Habilitar/Deshabilitar el boton Buscar
    function mensajeChange() {
          console.log("change");
          const campo1 = document.getElementById("idISBN");
          const campo2 = document.getElementById("idTitulo");
          const campo3 = document.getElementById("idAutor");
          const boton = document.getElementById("ActionBuscar");
          console.log(boton)
          
          if (campo1.value.trim() !== ""&&campo2.value.trim() !== ""&&campo3.value.trim() !== "") {
            console.log("Se muestra")
            boton.removeAttribute('disabled')
          } else {
            boton.setAttribute('disabled', "true");
          }
        }
  </script>

  <script>//Script para Habilitar/Deshabilitar el boton Aceptar
    function mensajeCreate() 
    {
      console.log("create");
      const campo1 = document.getElementById("id_isbn");
      const campo2 = document.getElementById("id_titulo");
      const campo3 = document.getElementById("id_autor");
      const campo4 = document.getElementById("id_editorial");
      const campo5 = document.getElementById("id_anioPublic");
      const boton = document.getElementById("id_aceptar");
      console.log(boton)

      if (campo1.value.trim() !== "" && campo2.value.trim() !== "" && campo3.value.trim() !== "" && campo4.value.trim() !== "" && campo5.value.trim() !== "") 
      {
        console.log("Se muestra")
        boton.removeAttribute('disabled')
      }
      else {
        boton.setAttribute('disabled', "true");
      }
    }
  </script>

  <script>
  function sortTable(n) 
  {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = document.getElementById('tabla_id');
    switching = true; 
    dir = "asc";
    while (switching) {
      switching = false;
      rows = table.rows;
      for (i = 1; i < (rows.length - 1); i++) {
        shouldSwitch = false;
        x = rows[i].getElementsByTagName("TD")[n];
        y = rows[i + 1].getElementsByTagName("TD")[n];
        if (dir == "asc") {
          if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
            shouldSwitch = true;
          break;
          }
        } else if (dir == "desc") {
          if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
            shouldSwitch = true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount ++;
    } else {
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}
</script>

<script>
  function retornar(){
    history.go(-1);
  }
</script>

</head>
<body bgcolor="#036169"> 
 
  <%!
    public Connection getConnection(String path) throws SQLException 
    {
      String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
      String filePath= path + "\\datos.mdb";
      String userName="",password="";
      String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

      Connection conn = null;
      try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        conn = DriverManager.getConnection(fullConnectionString,userName,password);
      }
      catch (Exception e) 
      {
        System.out.println("Error: " + e);
      }
      return conn;
    }
  %>
  <H1 style="text-align: center;">MANTENIMIENTO DE LIBROS</H1>
  <h3>Participantes:</h3>
  <div class="participantes">
    <p>Esteban Vladimir Acosta Casco - AC17063</p><hr>
    <p>Erick Samael Bermudez Alfaro - BA18048</p><hr>
    <p>David José Castro Clímaco - CC18117</p><hr>
    <p>Edwin Alexander Aparicio Cerón - AC18107</p><hr>
    <p>Julio Enrique de la Quadra Mata - DM14015</p><hr>
    <p>Herbert Daniel Chicas Duarte - CD17008</p><hr>
    <p>Rodrigo Eduardo Zelaya Fuentes - ZF17004</p>
</div>
<br>
<br>

<div class="primero">
  <form action="matto.jsp" method="post" name="Actualizar">
    <table id="hola">
      <tbody>
        <tr>
          <td class="etiqueta">ISBN 
          <td><input onkeyup="mensajeCreate()" id ="id_isbn" name="isbn" size="40" type="text" value="" /></td></td></tr>
        <tr>
          <td class="etiqueta">T&iacute;tulo 
          <td><input onkeyup="mensajeCreate()" id="id_titulo" name="titulo" size="50" type="text" value="" /></td></td></tr>
        <tr>
          <td class="etiqueta">Autor 
          <td><input onkeyup="mensajeCreate()" id="id_autor" name="autor" size="50" type="text" value="" /></td></td>
        </tr>
        <tr>
          <td class="etiqueta">Editorial 
          <%
          ServletContext context2 = request.getServletContext();
          String path2 = context2.getRealPath("/data");
          Connection conexion2 = getConnection(path2);
      
      
          if (!conexion2.isClosed())
          {
            
            Statement stEditorial = conexion2.createStatement();
            ResultSet rsEditorial = stEditorial.executeQuery("select * from editorial" );
          %>
          <td><select onkeyup="mensajeCreate()" id="id_editorial" name="editorial">
            <% while (rsEditorial.next()) { %>
              <option value="<% out.println(rsEditorial.getString("id")); %>"><% out.println(rsEditorial.getString("nombre")); %></option>
            <% } %>
          </select></td></td></tr>
          <% } %>
          <tr>
          <td class="etiqueta">Año de <br>Publicación  
            <td><input onkeyup="mensajeCreate()" id="id_anioPublic" name="anioPublic" size="30" type="text" value="" /></td></td>
          </tr>
          <tr>
            <td class="etiqueta">Action 
              <td>
                <input id="id_Actualizar" name="Action" type="radio" value="Actualizar" /> Actualizar 
                <input id="id_Eliminar" name="Action" type="radio" value="Eliminar" /> Eliminar 
                <input id="id_Crear" checked="checked" name="Action" type="radio" value="Crear" /> Crear
              <input id=id_aceptar type="submit" value="Aceptar" disabled></td>
            </td>
          </tr>
            <tr>
            <td><input id="btn-restaurar-1" type="reset" value="Restaurar"></td>
          </tr>
      </tbody>
      <img src="./imagenes/libros2_2118499843.jpg" alt="libros" height="70.5%" class="izquierda">
    </table>

  </form>

</div>
<div class="segundo">
  <form action="libros.jsp" name="formbusca" method="GET" class="form-control">
    <table class="tabla-2">
      <tbody>
        <tr><td class="etiqueta">ISBN: 
          <td>
            <input onkeyup="mensajeChange()" type="text" id="idISBN" name="isbn2" placeholder="ISBN del Libro:">
          </td>
        </td></tr>

        <tr><td class="etiqueta">Titulo: 
          <td>
            <input onkeyup="mensajeChange()" type="text" id="idTitulo" name="titulo2" placeholder="Titulo del Libro:">
          </td>
        </td></tr>

        <tr><td class="etiqueta">Autor: 
          <td>
            <input onkeyup="mensajeChange()" type="text" id="idAutor" name="autor2" placeholder="Autor del Libro:">
          </td>
        </td></tr>

    </tbody>
    </table>

    <input type="submit" id="ActionBuscar" value="Buscar" disabled>
    <input type="reset" value="Restaurar">
  </form>
</div>
    <h2 style="text-align:center;"><span>Lista de Libros</span></h2>
  <%
    ServletContext context = request.getServletContext();
    String path = context.getRealPath("/data");
    Connection conexion = getConnection(path);


    if (!conexion.isClosed())
    {
      String buscarISBN= request.getParameter("isbn2");
      String buscarTitulo= request.getParameter("titulo2");
      String buscarAutor= request.getParameter("autor2");
      if(buscarTitulo==null || buscarISBN==null||buscarAutor==null){

      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros inner join editorial on libros.id_editorial = editorial.id" );
      
      out.println("<table id='tabla_id' border=\"1\"><tr><th>Num.</th><th>ISBN</th>"+"<th onclick='sortTable(2);'>"+"<a href=\'#!\'>"+"Titulo"+"</a> </th>"+"<th>Autor</th>"+"<th>Editorial</th>"+"<th>Año Public</th>"+"<th>Acciones</th></tr>");
      int i=1;
      while (rs.next())
      {
        String var_isbn = rs.getString("isbn");
        String var_titulo = rs.getString("titulo");
        String var_autor = rs.getString("autor");
        String var_editorial = rs.getString("nombre");
        String var_id = rs.getString("id");
        String var_anioPublic = rs.getString("anioPublic");
        %>
  <tr>
    <td><% out.println(i); %></td>
    <td id='isbn_id<% out.println(i); %>'><% out.println(var_isbn); %></td>
    <td id='titulo_id<%out.println(i);%>'><% out.println(var_titulo); %></td>
    <td id='autor_id<%out.println(i);%>'><% out.println(var_autor); %></td>
    <td id='editorial_id<%out.println(i);%>'><% out.println(var_editorial); %></td>
    <td id='anioPublic_id<%out.println(i);%>'><% out.println(var_anioPublic); %></td>
    <td>
      <a href='#' id='<%out.println(i);%>' name='<% out.println(var_id); %>' onclick='actualizar(this, <% out.println(var_id); %>);'>Actualizar</a> | <% out.println("<a id="+"delete"+" href='matto.jsp?isbn="+var_isbn+"&titulo="+var_titulo+"&autor="+var_autor+"&nombre="+var_editorial+"&anioPublic="+var_anioPublic+"+&Action=Eliminar'>"+"Eliminar"+"</a>"); 
      %>
    </td>
  </tr>
  <%
        i++;
      }
      out.println("</table> <br><br>");
      } else {
        Statement st2 = conexion.createStatement();
        ResultSet rs=st2.executeQuery("select * from libros inner join editorial on libros.id_editorial = editorial.id where isbn LIKE"+"'%"+buscarISBN+"%'" +"OR titulo LIKE"+"'%"+buscarTitulo+"%'" +"OR autor LIKE"+"'%"+buscarAutor+"%'" );
        out.println("<table id='tabla_id' border=\"1\"><tr><th>Num.</th><th>ISBN</th>"+"<th onclick='sortTable(2);'>"+"<a href=\'#!\'>"+"Titulo"+"</a> </th>"+"<th>Autor</th>"+"<th>Editorial</th>"+"<th>Año Public</th>"+"<th>Acciones</th></tr>");
      int i=1;
      while (rs.next())
      {
        String var_isbn = rs.getString("isbn");
        String var_titulo = rs.getString("titulo");
        String var_autor = rs.getString("autor");
        String var_editorial = rs.getString("nombre");
        String var_id = rs.getString("id");
        String var_anioPublic = rs.getString("anioPublic");
%>
  <tr>
    <td><% out.println(i); %></td>
    <td id='isbn_id<% out.println(i); %>'><% out.println(var_isbn); %></td>
    <td id='titulo_id<%out.println(i);%>'><% out.println(var_titulo); %></td>
    <td id='autor_id<%out.println(i);%>'><% out.println(var_autor); %></td>
    <td id='editorial_id<%out.println(i);%>'><% out.println(var_editorial); %></td>
    <td id='anioPublic_id<%out.println(i);%>'><% out.println(var_anioPublic); %></td>
    <td>
      <a href='#' id='<%out.println(i);%>' name='<% out.println(var_id); %>' onclick='actualizar(this, <% out.println(var_id); %>);'>Actualizar</a> | <% out.println("<a id="+"delete"+" href='matto.jsp?isbn="+var_isbn+"&titulo="+var_titulo+"&autor="+var_autor+"&nombre="+var_editorial+"&anioPublic="+var_anioPublic+"+&Action=Eliminar'>"+"Eliminar"+"</a>"); 
      %>
    </td>
  </tr>
  <%
        i++;
      }
      out.println("</table> <br><br>");
      out.println("<a href="+"libros.jsp"+"> < Volver </a>");
      }
      conexion.close();
    }
  %>
  <a type=url style="margin-left: 10px;" href="listado-csv.jsp" download="listadoLibros.csv">Descargar Listado CSV</a>
  <a type=url style="margin-left: 10px;" href="listado-txt.jsp" download="listadoLibros.txt">Descargar Listado TXT</a>
  <a type=url style="margin-left: 10px;" href="listado-xml.jsp" download="listadoLibros.xml">Descargar Listado XML</a>
  <a type=url style="margin-left: 10px;" href="listado-json.jsp" download="listadoLibros.json">Descargar Listado JSON</a>
  <br><br><br>
</body>
</html>