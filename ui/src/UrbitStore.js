import Urbit from '@urbit/http-api';
import { writable } from 'svelte/store';

// init
const urbit = new Urbit("");

// stores
export const metas = writable(null);
export const active = writable("req");
export const draft = writable(null);
export const edit = writable(false);

// variables
export const frontType = [
      "statement", 
      "short", 
      "long", 
      "one", 
      "grid-one", 
      "grid-many",
      "linear-discrete",
      "linear-continuous",
      "calendar"
  ]

// store modifiers

export function updateMetas(ship, path) {
  scryUrbit(ship, path).then( res => metas.set(res))
}

export function setActive(ship, id) {
  const s = "/survey/" + id
  scryUrbit(ship, s).then( res => active.set(res))
} 

export function setDraft(ship, id) {
  const d = "/draft/" + id
//  scryUrbit(ship, d).then( res => draft.set(res))
  console.log("draft scry")
}

// question pokes

export function editQuestion(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {"qedit": data},
    onSuccess: ()=>(console.log("edit success")),
    onError: ()=>(console.log("error handling"))
})}

export function newQuestion(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {"qnew": data},
    onSuccess: ()=>(setActive(urbit.ship, data.surveyid)),
    onError: ()=>(console.log("error handling"))
  })
}

export function delQuestion(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {qdel: data},
    onSuccess: ()=>(setActive(urbit.ship, data.surveyid)),
    onError: ()=>(console.log("error handling"))
  })
}

// answer pokes

export function editDraft(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {dedit: data},
    onSuccess: ()=>(setDraft(urbit.ship, data.surveyid)),
    onError: ()=>(console.log("error handling"))
  })
}

// top panel related

export function requestSurvey(ship, data) {
  let arr = data.split("/")
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"ask":{"author": arr[0],"slug":arr[1]}},
      onSuccess: ()=>(updateMetas(ship, "/metas")),
      onError: ()=>(console.log("error handling"))
  })
}

export function createSurvey(ship, data) {
  if (data.title && data.description && data.slug) {
    urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"create": data},
      onSuccess: ()=>(updateMetas(ship, "/metas")),
      onError: ()=>(console.log("error handling"))
    })
  } else {console.log("details cannot be empty!")}
}

// internal only
function scryUrbit(ship, path) {
  urbit.ship = ship
  const msg = urbit.scry({
    app: "forms",
    path: path,
  })
  return msg
}

// unused for now
export function deleteSurvey(ship, data) {
  const urbit = new Urbit("")
  urbit.ship = ship
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"delete": data},
      onSuccess: ()=>(console.log("deleted survey")),
      onError: ()=>(console.log("error handling"))
  })
}
