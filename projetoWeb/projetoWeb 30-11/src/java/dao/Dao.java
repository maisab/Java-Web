/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Barreto
 */
public class Dao<T> {

    
    private static EntityManager em = Persistence.createEntityManagerFactory("UP").
            createEntityManager();
    private Class clazz;

    public Dao(Class clazz) {
        this.clazz = clazz;
    }

    public void insert(T entity) {
        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    public void update(T entity) {
        em.getTransaction().begin();
        em.merge(entity);
        em.getTransaction().commit();
    }

    public void remove(int id) {
        T obj = this.get(id);
        if (obj == null) {
            return;
        }
        em.getTransaction().begin();
        em.remove(obj);
        em.getTransaction().commit();
    }

    public T get(int id) {
        return (T) em.find(this.clazz, id);
    }

    public List<T> list() {
        return em.createQuery("SELECT c FROM " + clazz.getSimpleName() + " c").getResultList();
    }

    public List<T> listbyNome(String nome) {
        return em.createQuery("SELECT c FROM " + clazz.getSimpleName() + " c where c.nome like'%" + nome + "%'").getResultList();
    }
}
