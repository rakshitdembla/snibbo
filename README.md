# 💬 Snibbo – A Real-Time Social Media App

**Snibbo** is a modern full-stack social media application **inspired by Instagram**, combining clean UI with real-time functionality. Whether you're posting updates, chatting with friends, or viewing stories — Snibbo offers a smooth and engaging user experience in both **Dark** and **Light** modes.

> 🚀 Built with **Flutter** for a beautiful cross-platform frontend  
> 🧠 Powered by **Node.js**, **Express**, **MongoDB**, and **Socket.IO** for scalable, real-time backend operations  
> 🔗 Backend API: [Snibbo API Repository](https://github.com/rakshitdembla/snibbo_api)  
> 🧪 This is a full-stack project created as a showcase and learning experience — not an official app release  
> 🔗 **Deep Linking** is fully supported for shared posts and profile links — links automatically open inside the app

---

## 🚀 Feature Showcases

---

### 1. 🛫 Initial Screens  
**Onboarding, Login, Register, Forgot Password**

<table>
<tr>
<td width="60%" valign="middle">

<ul>
  <li>👋 <strong>Welcome Onboarding</strong> with engaging intro screens</li><br>
  <li>🔐 <strong>Login</strong> with secure email/password authentication</li><br>
  <li>📝 <strong>Register</strong> with real-time input validation</li><br>
  <li>🧠 <strong>Forgot Password</strong> screen for quick recovery</li><br>
  <li>🌗 Designed to perfection in both <strong>Light</strong> and <strong>Dark</strong> modes</li>
</ul>

</td>
<td width="40%">
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752187101/Multiple_screens_zscea9.png" width="100%" style="margin-bottom: 10px;"/><br>
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752187108/Multiple_screens_uqwba2.png" width="100%"/>
</td>
</tr>
</table>

---

### 2. 📸 Stories  
**Create, View, Delete + Story Border Logic**

<table>
<tr>
<td width="60%" valign="top">

<ul>
  <li>📲 <strong>Create Story</strong> by swiping left-to-right on the home feed</li><br>
  <li>🖼️ Opens a <strong>Bottom Sheet</strong> to select images from the gallery</li><br>
  <li>🛠️ Full <strong>Story Editor</strong> with:
    <ul>
      <li>✂️ Crop</li>
      <li>🔤 Add Text</li>
      <li>🖍️ Paint / Draw</li>
      <li>🎨 Apply Filters</li>
    </ul>
  </li><br>
  <li>☁️ Upload story after editing</li><br>
  <li>🗑️ <strong>Delete</strong> your active story anytime</li><br>
  <li>👁️ <strong>Story Views</strong> tracked & visible to uploader</li><br>
  <li>🟣 <strong>Border Logic</strong> like Instagram:
    <ul>
      <li>🔵 Blue ring → Unseen story</li>
      <li>⚪ Grey ring → All stories seen</li>
      <li>🚫 No ring → No active stories</li>
    </ul>
  </li><br>
  <li>🔄 Smart <strong>pagination</strong> (unseen first, latest next)</li><br>
  <li>⚙️ Robust <strong>state management</strong> — viewable from any screen</li>
</ul>

</td>
<td width="40%">
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752187419/Dribble_show_31_purtna.png" width="100%" style="margin-bottom: 10px;"/><br>
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752187425/Dribble_show_31_dpkxkv.png" width="100%"/>
</td>
</tr>
</table>

---

### 3. 📝 Posts  
**Create, Read, Like, Save, Comment, Share, Report**

<table>
<tr>
<td width="60%" valign="middle">

<ul>
  <li>➕ <strong>Create Image Posts</strong> with captions</li><br>

  <li>📥 <strong>Read Posts</strong> in two feeds:
    <ul>
      <li>🧑‍🤝‍🧑 <strong>Feed:</strong> Prioritizes your followings’ posts</li>
      <li>🌎 <strong>Explore:</strong> Global posts with proper pagination</li>
    </ul>
  </li><br>

  <li>📝 <strong>Long Captions</strong> are trimmed with <strong>"See more / See less"</strong> toggle just like Instagram</li><br>

  <li>❤️ <strong>Like by Double Tap</strong> — triggers heart animation</li><br>

  <li>💾 <strong>Save Posts</strong> — shows animation and saves are <strong>public</strong> (visible to everyone)</li><br>

  <li>👆 <strong>Hold on a post</strong> to view the full list of users who liked it:
    <ul>
      <li>🧑‍🤝‍🧑 Shows your followings first</li>
      <li>🔍 Debounce-based search available on that screen</li>
    </ul>
  </li><br>

  <li>🔗 <strong>Share or Report</strong> options:
    <ul>
      <li>📎 Copy post link via share icon</li>
      <li>⚠️ Report post via top-right 3-dot menu</li>
    </ul>
  </li><br>

  <li>💬 <strong>Comment & Reply (CRUD)</strong> with instant state updates:
    <ul>
      <li>📝 Add or delete comments & replies in real-time — no refresh needed</li>
      <li>📂 Pagination for both comments and replies</li>
      <li>👆 <strong>Hold on a comment or reply</strong> to view who liked it:
        <ul>
          <li>🧑‍🤝‍🧑 Prioritizes your followings</li>
          <li>🔍 Includes smart search with debounce</li>
        </ul>
      </li>
    </ul>
  </li><br>

  <li>🧠 Everything is powered by strong state management</li><br>

  <li>📷 These post-related features are directly <strong>inspired by Instagram</strong> and are cloned with similar UX and logic</li>

</ul>

</td>
<td width="40%">
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752188097/Dribble_show_56_ozddhm.png" width="100%" style="margin-bottom: 10px;"/><br>
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752188107/Dribble_show_56_qptl0n.png" width="100%"/>
</td>
</tr>
</table>

---

### 4. 👤 Profile  
**Edit Profile, View Posts, Follow System, Global Search**

<table>
<tr>
<td width="60%" valign="middle">

<ul>
  <li>🛠️ <strong>Edit Profile</strong> with:
    <ul>
      <li>📝 Username</li>
      <li>👤 Name</li>
      <li>📄 Bio</li>
    </ul>
    All updates happen instantly.
  </li><br>

  <li>🔗 <strong>Share Profile</strong> — copies your profile link to clipboard</li><br>

  <li>🖼️ <strong>Tabbed Layout:</strong>
    <ul>
      <li>📸 Your Posts</li>
      <li>💾 Saved Posts</li>
    </ul>
    Tabs are scrollable, and the app bar stays pinned — just like Instagram.<br>
    📂 Both tabs include <strong>pagination</strong> to efficiently load large numbers of posts.
  </li><br>

  <li>🔄 <strong>Refresh Button</strong> on top-right:
    <ul>
      <li>✨ Visible on all profiles (your own & others)</li>
      <li>🎞️ Triggers a smooth pull-down animation</li>
    </ul>
  </li><br>

  <li>⚙️ <strong>Settings</strong> (only on your own profile):
    <ul>
      <li>🌗 Instantly switch between Light/Dark themes</li>
      <li>🔐 Privacy Policy</li>
      <li>📄 Terms & Conditions</li>
      <li>🗑️ Request Account Deletion</li>
      <li>🚪 Logout</li>
    </ul>
  </li><br>

  <li>👥 Viewing another user’s profile:
    <ul>
      <li>🤝 Follow / Unfollow buttons</li>
      <li>💬 Message button</li>
      <li>🎞️ Story ring shown if story is active (same border behavior)</li>
    </ul>
  </li><br>

  <li>📊 <strong>Followers / Following Tabs:</strong>
    <ul>
      <li>🚀 Open by tapping on follower/following count</li>
      <li>📂 Two tabs: Followers & Following</li>
      <li>🔍 Search with debounce</li>
      <li>🎯 Prioritizes your followings in the list</li>
      <li>🔄 Includes <strong>pagination</strong> for large user lists</li>
    </ul>
  </li><br>

  <li>🔎 <strong>Global User Search</strong>:
    <ul>
      <li>📲 Accessed via Explore page</li>
      <li>🌍 Search any user globally by username</li>
      <li>⚡ Real-time search with debounce</li>
      <li>🤝 Follow / Unfollow directly from results</li>
    </ul>
  </li><br>

  <li>🧠 Fully managed with global state and real-time updates — no page refresh required</li><br>

  <li>📱 This entire profile module is closely <strong>cloned from Instagram</strong> — including tabs, follow UX, and scroll behaviors</li>

</ul>

</td>
<td width="40%">
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752188853/Dribble_show_56_vvq22l.png" width="100%" style="margin-bottom: 10px;"/><br>
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752188861/Dribble_show_56_trjtwj.png" width="100%"/>
</td>
</tr>
</table>

---

### 5. 💬 Chat  
**Real-Time One-to-One Messaging with Online Status, Typing, Pagination, and Blocking**

<table>
<tr>
<td width="60%" valign="middle">

<ul>
  <li>💬 <strong>Message Any User</strong> directly from their profile using the Message button</li><br>

  <li>📩 <strong>Chats Icon</strong> is located at the top-right of the feed page — tapping it opens the <strong>Recent Chats</strong> screen</li><br>

  <li>📂 <strong>Recent Chats List:</strong>
    <ul>
      <li>🧾 Fully paginated for large conversation history</li>
      <li>➡️ <strong>Slide right to left</strong> on any user to access:
        <ul>
          <li>🚫 Block</li>
          <li>✅ Unblock</li>
        </ul>
        Blocked users cannot message you, and vice versa
      </li>
    </ul>
  </li><br>

  <li>📬 <strong>Chat Screen:</strong>
    <ul>
      <li>📜 Shows complete message history (paginated)</li>
      <li>🔄 Real-time two-way messaging using Socket.IO</li>
      <li>⌨️ Typing indicator when the other user is typing</li>
      <li>🟢 <strong>Online/Offline Status:</strong>
        <ul>
          <li>🟢 Online – shown below username</li>
          <li>🕓 Last seen – if offline</li>
        </ul>
      </li>
    </ul>
  </li><br>

  <li>🧠 Chat system is built with robust state management and socket-based architecture — delivering a smooth, real-time experience without any page refresh</li>

</ul>

</td>
<td width="40%">
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752189798/Dribble_show_39_i4kuwi.png" width="100%" style="margin-bottom: 10px;"/><br>
  <img src="https://res.cloudinary.com/dclbuwvtm/image/upload/v1752189803/Dribble_show_39_n92ymc.png" width="100%"/>
</td>
</tr>
</table>

---



