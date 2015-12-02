/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import dao.Dao;


/**
 *
 * @author aluno
 */
public class Main {
    
    public static void main(String[] args) {
       
        Estado e1 = new Estado("Acre");
        Estado e2 = new Estado("Alagoas");
        Estado e3 = new Estado("Amapá");
        Estado e4 = new Estado("Amazonas");
        Estado e5 = new Estado("Bahia");
        Estado e6 = new Estado("Ceará");
        Estado e7 = new Estado("Distrito Federal");
        Estado e8 = new Estado("Goiás");
        Estado e9 = new Estado("Espírito Santo");
        Estado e10 = new Estado("Maranhão");
        Estado e11 = new Estado("Mato Grosso");
        Estado e12 = new Estado("Mato Grosso do Sul");
        Estado e13 = new Estado("Minas Gerais");
        Estado e14 = new Estado("Pará");
        Estado e15 = new Estado("Paraiba");
        Estado e16 = new Estado("Paraná");
        Estado e17 = new Estado("Pernambuco");
        Estado e18 = new Estado("Piauí");
        Estado e19 = new Estado("Rio de Janeiro");
        Estado e20 = new Estado("Rio Grande do Norte");
        Estado e21 = new Estado("Riod Grande do Sul");
        Estado e22 = new Estado("Rondônia");
        Estado e23 = new Estado("Rorâima");
        Estado e24 = new Estado("São Paulo");
        Estado e25 = new Estado("Santa Catarina");
        Estado e26 = new Estado("Sergipe");
        Estado e27 = new Estado("Tocantins");
        
       
        Dao<Estado> dao = new Dao<Estado>(Estado.class);
        dao.insert(e1);
        dao.insert(e2);
        dao.insert(e3);
        dao.insert(e4);
        dao.insert(e5);
        dao.insert(e6);
        dao.insert(e7);
        dao.insert(e8);
        dao.insert(e9);
        dao.insert(e10);
        dao.insert(e11);
        dao.insert(e12);
        dao.insert(e13);
        dao.insert(e14);
        dao.insert(e15);
        dao.insert(e16);
        dao.insert(e17);
        dao.insert(e18);
        dao.insert(e19);
        dao.insert(e20);
        dao.insert(e21);
        dao.insert(e22);
        dao.insert(e23);
        dao.insert(e24);
        dao.insert(e25);
        dao.insert(e26);
        dao.insert(e27);
        
        
    }
    
}
