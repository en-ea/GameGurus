// Get the functions in the db.js file to use
const db = require('../services/db');
const { Programme } = require('./programme');
const { Module } = require('./module');

class Student {
    // Student ID
    id;
    // Student name
    name;
    // Student programme
    programme;
    // Student modules
    modules = [];

    constructor(id) {
        this.id = id;
    }

    // Get the student name from the database
    async getStudentName() {
        if (typeof this.name !== 'string') {
            var sql = "SELECT * from Students where id = ?"
            const results = await db.query(sql, [this.id]);
            this.name = results[0].name;
        }
    }

    // Get the programme of this student
    async getStudentProgramme() {
        if (typeof this.programme !== Programme) {
            var sql = "SELECT * from Programmes p \
            JOIN Student_Programme sp ON p.id = sp.programme \
            WHERE sp.id = ?"
            const results = await db.query(sql, [this.id]);
            this.programme = new Programme(results[0].programme);
            this.programme.pName = results[0].name;
        }
    }

    async getStudentModules() {
        var sql = "SELECT * FROM Programme_Modules pm \
            JOIN Modules m ON m.code = pm.module \
            WHERE programme = ?"
            const results = await db.query(sql, [this.programme.id]);
            for (var row of results) {
                this.modules.push(new Module(row.code, row.name));
            }
    }
}

module.exports = {
    Student
}