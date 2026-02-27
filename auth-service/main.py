from contextlib import asynccontextmanager
from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import text
from sqlalchemy.orm import Session

from database import Base, User, engine
from schemas import TokenResponse, UserCredentials, UserResponse
from security import (
    create_access_token,
    get_current_user,
    get_db,
    get_password_hash,
    verify_password,
)


@asynccontextmanager
async def lifespan(app: FastAPI):
    with engine.begin() as conn:
        conn.execute(text("SELECT pg_advisory_lock(424243)"))
        Base.metadata.create_all(bind=conn)
        conn.execute(text("SELECT pg_advisory_unlock(424243)"))
    yield


app = FastAPI(title="Grabler Shared Auth", version="0.1.0", lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://grabler.me", "https://go.grabler.me", "https://namo.grabler.me"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/api/auth/register", response_model=TokenResponse)
def register_user(user: UserCredentials, db: Session = Depends(get_db)) -> TokenResponse:
    existing_user = db.query(User).filter(User.username == user.username).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username already registered",
        )

    db_user = User(
        username=user.username.strip(),
        password_hash=get_password_hash(user.password),
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return TokenResponse(access_token=create_access_token(db_user))


@app.post("/api/auth/login", response_model=TokenResponse)
def login_user(user: UserCredentials, db: Session = Depends(get_db)) -> TokenResponse:
    db_user = db.query(User).filter(User.username == user.username).first()
    if db_user is None or not verify_password(user.password, str(db_user.password_hash)):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
        )
    return TokenResponse(access_token=create_access_token(db_user))


@app.get("/api/auth/me", response_model=UserResponse)
def get_me(current_user: User = Depends(get_current_user)) -> UserResponse:
    return UserResponse(
        id=current_user.id,
        username=current_user.username,
        created_at=current_user.created_at,
    )
