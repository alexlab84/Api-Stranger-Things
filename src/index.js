//Importamos librerias

const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

// Conexion a mysql
const getConnection = require('./db/db');



// Auth
const bcrypt = require("bcrypt");


// Variables

const server = express();
const port = 4000;

// Configuracion de espress

server.use(cors());
server.use(express.json({limit: '25mb'}));


server.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
  });


// ENDPOINTS API

// Listar

server.get('/api/stranger_things', async(req, res) => {

    // Obtener conn con la base de datos
    const conn = await getConnection();

    if(!conn) {
        res.status(500).json({success: false, error: 'Error con la conexión'})
        return;
    }

    // Lanzamos una query

    const[results] = await conn.query('SELECT * FROM capitulos');

    res.json(results);

    // Cerramos conexión

    await conn.close();

});

// Insertar

server.post('/api/stranger_things', async(req, res) => {
    // Obtener conexión
    const conn = await getConnection();

    if(!conn) {
        res.status(500).json({success: false, error: 'Error con la conexión'})
        return;
    }

    // Comprobamos campos

    if(!req.body.numero) {
        res.json({success: false, error: 'Falta el numero'});
        return;
      }
    
      if(!req.body.titulo) {
        res.json({success: false, error: 'Falta el titulo'});
        return;
      }

    const[results] = await conn.execute(`
        INSERT capitulos (id, numero, titulo, fecha_estreno, valoracion)
        VALUES (?, ?, ?, ?, ?);`, 
    [req.body.id, req.body.numero, req.body.titulo, req.body.fecha_estreno, req.body.valoracion]);


    if(results.affectedRows === 1) {
        res.json({success: true, id: results.insertId});
      }
      else {
        res.json({success: false, error: 'No insertado'});
      }
    
    await conn.close();
});


server.put('/api/stranger_things/:id', async(req, res) => {

    // Obtener conn

    const conn = await getConnection();

    if(!conn) {
        res.status(500).json({success: false, error: 'Error con la conexion.'});
        return;
      }

      // UPDATE a la base de datos

      const [results] = await conn.execute(`
        UPDATE capitulos
        SET id=?, numero=?, titulo=?, fecha_estreno=?, valoracion=?
        WHERE id=?
        `,
    [req.body.id, req.body.numero, req.body.titulo, req.body.fecha_estreno, req.body.valoracion, req.params.id])


    if(results.changedRows === 0) {
        res.json({success: false});
      }
      else {
        res.json({success: true});
      }
    
      // Cierro la conn
      await conn.close();

});


server.delete('/api/stranger_things/:id', async(req, res) => {
    // Obtener una conn
  
    const conn = await getConnection();
  
    if(!conn) {
      res.status(500).json({success: false, error: 'Error con la conexion.'});
      return;
    }
  
    // Borro una fila en la bbdd con DELETE FROM
  
    const[results] = await conn.execute(`
      DELETE FROM capitulos
      WHERE id = ?`,
      [req.params.id]);
  
    // Devuelvo un json, success:true, success:false
  
    console.log(results);
    
    if(results.affectedRows === 0) {
      res.json({success: false});
    }
    else {
      res.json({success: true});
    }
  
    // Cierro la conn
    await conn.close();
  });

  // POST /api/usuarias

  server.post('/api/usuarias', async(req, res) => {
    console.log(req.body);
    
    const conn = await getConnection();

    const hashPass = await bcrypt.hash(req.body.password, 10);

    const [results] = await conn.execute(`
        INSERT INTO usuarias (email, password, nombre)
        VALUES (?, ?, ?)`,
        [req.body.email, hashPass, req.body.nombre] );
    
        console.log(results);
        
        if(results.affectedRows === 1) {
            res.json({
              success: true,
              id: results.insertId
            })
          }
          else {
            res.json({
              success: false,
              error: "No insertado"
            })
          }
        
          // Cerrar la conn
          await conn.close();
  });


  server.post('/api/login', async(req, res) => {
    console.log(req.body);
    
    // Conn a la bbdd
  
    const conn = await getConnection();
  
    // Consultar usuarias <- SELECT FROM users
  
    const [results] = await conn.query(`
      SELECT *
        FROM usuarias
        WHERE email = ?
      `,
      [req.body.email]);
  
    // Comprobar los results
  
    if(results.length === 0) {
      res.json({
        success: false,
        error: "Credenciales no válidas"
      });
      return;
    }
  
    const userFound = results[0];
  
    //if( userFound.pass === req.body.pass ) {
    if(bcrypt.compareSync(req.body.password, userFound.password)) {
  
      // Generar un TOKEN JWT!!!
  
      res.json({
        success: true,
        token: userFound.id,  // De momento el TOKEN es el iduser de la tabla
      });
    }
    else {
      res.json({
        success: false,
        error: "Credenciales no válidas"
      });
      return;
    }
  
    console.log(results);
    
  
    // Cerrar la conn
    await conn.close();
  });