    import express, { Request, Response } from "express";
    import mysql from "mysql2/promise";

    const app = express();

    app.set('view engine', 'ejs');
    app.set('views', `${__dirname}/views`);

    const connection = mysql.createPool({
        host: process.env.DB_HOST || "localhost",
        user: process.env.DB_USER || "root",
        password: process.env.DB_PASSWORD || "mudar123",
        database: process.env.DB_NAME || "unicesumar"
    });

    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));

    app.get('/categories', async (req: Request, res: Response) => {
        const [rows] = await connection.query("SELECT * FROM users");
        res.render('categories/index', { users: rows });
    });

    app.get('/categories/add', (req: Request, res: Response) => {
        res.render('categories/form');
    });

    app.post('/categories', async (req: Request, res: Response) => {
        const { name, email, password, role, active } = req.body;
        const insertQuery = 'INSERT INTO users (name, email, password, role, active) VALUES (?, ?, ?, ?, ?)';
        await connection.query(insertQuery, [name, email, password, role, active]);
        res.redirect('/categories');
        
        if (!name || !email || !password || !role || (active !== '0' && active !== '1')) {
            return res.status(400).send("Todos os campos são obrigatórios.");
        }
    
    
    });
 
  

    app.post('/categories/:id/delete', async (req: Request, res: Response) => {
        const id = req.params.id;
        const deleteQuery = "DELETE FROM users WHERE id = ?";
        await connection.query(deleteQuery, [id]);
        res.redirect('/categories');
    });


    app.get('/login', (req: Request, res: Response) => {
        res.render('login');
    });

    app.post('/login', async (req: Request, res: Response) => {
        const { email, password } = req.body;
        const [rows]: any = await connection.query("SELECT * FROM users WHERE email = ? AND password = ?", [email, password]);
        
        if (rows.length > 0) {
           
            await connection.query("INSERT INTO login_logs (email, status) VALUES (?, 'success')", [email]);
            return res.redirect('/categories'); 
        } else {
           
            await connection.query("INSERT INTO login_logs (email, status) VALUES (?, 'failure')", [email]);
            return res.redirect('/login');
        }
    });
    


    app.get('/', (req: Request, res: Response) => {
        res.render('home');
    });

    app.listen(3000, () => console.log("Server is listening on port 3000"));