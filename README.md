# Caliber Backend API

Designing a REST API with **Node.js**, **Express**, and **Mongoose** requires following some best practices to ensure scalability, maintainability, and performance. Below are the essential best practices for designing such an API:

### 1. **Project Structure**
Organize the project for easy maintenance and scalability. For a simple Node.js + Express app, you can start with:

```
/project-root
│
├── /src
│   ├── /controllers        # Business logic and request handling
│   ├── /models             # Mongoose models (schemas)
│   ├── /routes             # API routes
│   ├── /middleware         # Custom middleware functions
│   ├── /services           # Helper services (e.g., for interacting with 3rd party APIs)
│   ├── /config             # Configuration (environment variables, DB, etc.)
│   ├── /utils              # Utility functions/helpers
│   └── app.js              # Express app setup
│
├── .env                    # Environment variables
├── package.json            # Dependencies
└── server.js               # Entry point
```

### 2. **Versioning API**
Include versioning in your API URL, such as `/api/v1/users`. This allows you to introduce breaking changes while maintaining backward compatibility:

```js
app.use('/api/v1/users', userRoutes);
```

### 3. **Use Middleware**
Leverage **middleware** for common functionality like authentication, error handling, and logging.

- **Authentication**: Implement authentication middleware (e.g., JWT) to secure your routes.
  
- **Validation**: Validate incoming request data using libraries like `express-validator` or `Joi`.

- **Logging**: Use logging libraries like `morgan` for request logging, which helps in monitoring and debugging.

Example: 
```js
const authMiddleware = require('./middleware/auth');
app.use('/api/v1/users', authMiddleware, userRoutes);
```

### 4. **Use Controllers to Manage Business Logic**
Separate business logic from routes by using **controllers**. This keeps routes clean and manageable.

```js
// routes/userRoutes.js
const express = require('express');
const userController = require('../controllers/userController');
const router = express.Router();

router.get('/', userController.getAllUsers);
router.post('/', userController.createUser);

module.exports = router;
```

```js
// controllers/userController.js
// Create User
const createUser = async (name, email, password) => {
  try {
    const user = await User.create({ name, email, password });
    return user;
  } catch (error) {
    console.error('Error creating user:', error);
  }
};

// Get All Users
const getAllUsers = async () => {
  try {
    const users = await User.findAll();
    return users;
  } catch (error) {
    console.error('Error fetching users:', error);
  }
};

// Get User by ID
const getUserById = async (id) => {
  try {
    const user = await User.findByPk(id);
    return user;
  } catch (error) {
    console.error('Error fetching user:', error);
  }
};

// Update User
const updateUser = async (id, updatedData) => {
  try {
    const user = await User.findByPk(id);
    if (user) {
      await user.update(updatedData);
      return user;
    }
  } catch (error) {
    console.error('Error updating user:', error);
  }
};

// Delete User
const deleteUser = async (id) => {
  try {
    const user = await User.findByPk(id);
    if (user) {
      await user.destroy();
    }
  } catch (error) {
    console.error('Error deleting user:', error);
  }
};

// Sync the model with the database
sequelize.sync()
  .then(() => console.log('Database synced'))
  .catch(err => console.error('Error syncing database:', err));

module.exports = { createUser, getAllUsers, getUserById, updateUser, deleteUser };
```

### 5. **Error Handling**
Use centralized error handling middleware to catch and respond to errors uniformly:

```js
// middleware/errorHandler.js
function errorHandler(err, req, res, next) {
  console.error(err.stack);
  res.status(500).send({ message: err.message });
}

module.exports = errorHandler;
```

In your app, use this middleware after routes:

```js
const errorHandler = require('./middleware/errorHandler');
app.use(errorHandler);
```

To convert this MongoDB/Mongoose schema to a MySQL-compatible schema using an ORM like Sequelize or raw SQL queries, here's an equivalent structure using Sequelize for MySQL.

### 6. Sequelize (MySQL)

1. Install Sequelize and MySQL dependencies:
   ```bash
   npm install sequelize mysql2
   ```

2. Create a `User` model using Sequelize:

```javascript
const { Sequelize, DataTypes } = require('sequelize');

// Initialize Sequelize with your MySQL connection details
const sequelize = new Sequelize('database_name', 'username', 'password', {
  host: 'localhost',
  dialect: 'mysql',
});

// Define the User model
const User = sequelize.define('User', {
  name: {
    type: DataTypes.STRING,
    allowNull: false, // equivalent to required: true
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true, // equivalent to unique: true
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
}, {
  timestamps: true, // equivalent to Mongoose's { timestamps: true }
});

// Export the model
module.exports = User;
```

**MySQL Explanation:**

- **Sequelize:** Sequelize is used as an ORM for MySQL, replacing Mongoose, which is designed for MongoDB.
- **DataTypes:** Sequelize provides data types such as `STRING`, `INTEGER`, etc., similar to Mongoose types like `String`.
- **allowNull: false:** This is the equivalent of `required: true` in Mongoose.
- **unique: true:** This makes the `email` field unique in the database.
- **timestamps: true:** Automatically adds `createdAt` and `updatedAt` fields, just like in Mongoose.

You can now use this Sequelize model to interact with your MySQL database, performing operations like creating users, updating them, etc.

### 7. **Use Environment Variables**
Store sensitive information such as API keys, DB connection strings, and other configurations in environment variables (`.env` file).

```js
// .env
PORT=3000
DATABASE_NAME=your_database_name
USERNAME=admin
PASSWORD=admin123
```

Access them in the code via `process.env`:

```js
require('dotenv').config();
const mongoose = require('mongoose');

// Initialize Sequelize with your MySQL connection details
const sequelize = new Sequelize(process.env.DATABASE_NAME', process.env.USERNAME, process.env.PASSWORD, {
  host: 'localhost',
  dialect: 'mysql',
});
```

### 8. **Request Validation and Sanitization**
Validate request data before processing. You can use libraries like `express-validator` or `Joi` to validate incoming requests:

```js
const { check, validationResult } = require('express-validator');

router.post(
  '/',
  [
    check('name').isString().notEmpty(),
    check('email').isEmail(),
    check('password').isLength({ min: 6 }),
  ],
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    next();
  },
  userController.createUser
);
```

### 9. **Paginate Large Responses**
When dealing with large datasets, paginate the results to improve performance and client experience:

```js
router.get('/', async (req, res) => {
  const { page = 1, limit = 10 } = req.query;
  const users = await User.find()
    .limit(limit * 1)
    .skip((page - 1) * limit)
    .exec();
  const count = await User.countDocuments();
  
  res.json({
    users,
    totalPages: Math.ceil(count / limit),
    currentPage: page
  });
});
```

### 10. **HTTP Status Codes**
Use the correct HTTP status codes to indicate the result of an operation:

- `200 OK` for successful GET requests.
- `201 Created` for successful POST requests that result in resource creation.
- `400 Bad Request` for validation errors.
- `404 Not Found` if the resource doesn’t exist.
- `500 Internal Server Error` for unexpected failures.

### 11. **Security Practices**
- **Use HTTPS** to secure communication.
- **Sanitize inputs** to prevent SQL injections or NoSQL injections (e.g., `express-mongo-sanitize`).
- **Rate Limiting**: Limit API calls to prevent abuse (e.g., `express-rate-limit`).
- **Helmet**: Use `helmet` middleware to set various HTTP headers for security:

```js
const helmet = require('helmet');
app.use(helmet());
```

### 12. **Testing**
Write unit and integration tests for your API. Use testing frameworks like **Jest**, **Mocha**, or **Supertest** to ensure the API works as expected.

Example of a simple test with **Jest**:
```js
const request = require('supertest');
const app = require('../app');

describe('GET /api/v1/users', () => {
  it('should return a list of users', async () => {
    const res = await request(app).get('/api/v1/users');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('users');
  });
});
```

### 13. **Documentation**
Document your API using **Swagger** or **Postman** to provide clear and comprehensive details to developers.

- Swagger: Use **swagger-ui-express** and **swagger-jsdoc** to auto-generate API docs:

```js
const swaggerJsDoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const swaggerOptions = {
  swaggerDefinition: {
    info: {
      title: 'User API',
      version: '1.0.0',
    },
  },
  apis: ['./routes/*.js'],
};

const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));
```

### Conclusion
By following these best practices, you can create a REST API that is secure, maintainable, and scalable.
