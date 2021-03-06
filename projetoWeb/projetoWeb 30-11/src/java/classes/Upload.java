package classes;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

public class Upload {

    private String path;

    public Upload(String path) {
        this.path = path;

        if (!this.isDirectoryExists(path)) {
            createDirectory(path);
        }

    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    /**
     *
     * Testa se o paramêtro caminho (path) existe.
     */
    private boolean isDirectoryExists(String path) {
        File file = new File(path);
        return file.exists() ? true : false;
    }

    /**
     *
     * Cria o diretorio baseado no paramêtro caminho (path).
     */
    private void createDirectory(String path) {
        File file = new File(path);
        if (!file.exists()) {
            file.mkdir();
        }
    }

    private void saveFile(String path, String fileName, FileItem fileItem) {
        try {
            File file = new File(path, fileName);
            FileOutputStream output = new FileOutputStream(file);
            InputStream is = fileItem.getInputStream();

            byte[] buffer = new byte[2048];
            int nLidos;

            while ((nLidos = is.read(buffer)) >= 0) {
                output.write(buffer, 0, nLidos);
            }
            output.flush();
            output.close();
        } catch (FileNotFoundException ex) {
            System.out.println(ex.getMessage());
        } catch (IOException ex) {
            System.out.println(ex.getMessage());
        }
    }

    /**
     * Retorna em um Map os campos do formulário exceto o campo da imagem.
     */
    public Map<String, String> getFormValues(List l) {
        Map<String, String> map = new HashMap<String, String>();
        Iterator iter = l.iterator();

        while (iter.hasNext()) {

            FileItem item = (FileItem) iter.next();
            
            if (item.isFormField()) {
                map.put(item.getFieldName(), item.getString());
            } else {
                if (item.getName().length() > 0) {
                    this.saveFile(this.getPath(), this.getNameFile(item), item);
                    map.put(item.getFieldName(), this.getNameFile(item));
                    item.delete();
                }
            }
        }
        return (map.size() > 0) ? map : null;
    }

    private String getNameFile(FileItem fileItem) {
        String name = fileItem.getName();
        String arq[] = name.split("\\\\");
        for (int i = 0; i < arq.length; i++) {
            name = arq[i];
        }
        return name;
    }

    public List processRequest(HttpServletRequest req) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            return upload.parseRequest((RequestContext) req);
        } catch (FileUploadException ex) {
            return null;
        }
    }

   public String[] getAllImages(){
        File dir = new File(this.getPath());
        return dir.list();
    }
}